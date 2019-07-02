//
//  ViewController.swift
//  TikiHomeAssignment
//
//  Created by Phuc Hoang on 7/1/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  @IBOutlet weak var keywordCollectionView: UICollectionView!
  var keywords: [Keyword]? = nil
  let service: Service = Service(webAPI: WebAPI.shared)

  override func viewDidLoad() {
    super.viewDidLoad()
    service.getKeywords(completion: { keywords in
      if let keywords = keywords {
        self.keywords = keywords
        self.keywordCollectionView.reloadData()
      }
    })
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
    print("Actual width item \(indexPath.row) is \(estimatedWidth)")
    return CGSize(width: actualWidth, height: 200.0)
  }
}
