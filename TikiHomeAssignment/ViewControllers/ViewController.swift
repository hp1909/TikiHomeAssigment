//
//  ViewController.swift
//  TikiHomeAssignment
//
//  Created by Phuc Hoang on 7/1/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  @IBOutlet weak var keywordCollectionView: UICollectionView!
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  
  var keywords: [Keyword]? = nil
  var viewModel: ViewModel?
  let disposeBag = DisposeBag()
  
  private let viewWillAppearSubject = PublishSubject<Void>()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.viewWillAppearSubject.onNext(Void())
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindViewModel()
  }
  
  func viewWillAppearObservable() -> Observable<Void> {
    return self.viewWillAppearSubject.asObservable()
  }
  
  func bindViewModel() {
    let input = ViewModel.Input(viewWillAppearObservable: self.viewWillAppearObservable())
    let output = self.viewModel?.transform(input: input)
    output?.isLoadingObservable
      .map { !$0 }
      .bind(to: self.loadingIndicator.rx.isHidden)
      .disposed(by: self.disposeBag)
    
    output?.isLoadingObservable
      .bind(to: self.loadingIndicator.rx.isAnimating)
      .disposed(by: self.disposeBag)
    
    output?.keywordsObservable.subscribe(onNext: { [weak self] data in
      guard let `self` = self else {
        return
      }
      
      self.keywords = data
      self.keywordCollectionView.reloadData()
    })
    .disposed(by: self.disposeBag)
  }
  
  // MARK: Setup Keywords Collection View
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let size = self.keywords?.count else {
      return 0
    }
    return size
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = self.keywordCollectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCollectionViewCell", for: indexPath) as! KeywordCollectionViewCell
    cell.thumbnail.loadImage(url: self.keywords?[indexPath.row].icon)
    cell.keywordLabel.text = self.keywords?[indexPath.row].keyword
    let keywordColor = UIColor(hexString: Constants.KEYWORD_COLORS[indexPath.row % Constants.KEYWORD_COLORS.count])
    cell.keywordContainer.backgroundColor = keywordColor
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard let text = self.keywords?[indexPath.row].keyword else {
      return collectionView.frame.size
    }
    
    let estimatedWidth = text.balanceLines()
    let actualWidth = estimatedWidth > Constants.MIN_KEYWORD_CELL_WIDTH ? estimatedWidth : Constants.MIN_KEYWORD_CELL_WIDTH

    return CGSize(width: actualWidth, height: 200.0)
  }
}
