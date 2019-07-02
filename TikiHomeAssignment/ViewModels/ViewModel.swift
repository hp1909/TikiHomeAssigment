//
//  ViewModel.swift
//  TikiHomeAssignment
//
//  Created by Phuc Hoang on 7/2/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelProtocol: class {
  associatedtype Input
  associatedtype Output
}

class ViewModel: ViewModelProtocol {
  struct Input {
    let viewWillAppearObservable: Observable<Void>
  }
  
  struct Output {
    let isLoadingObservable: Observable<Bool>
    let keywordsObservable: Observable<[Keyword]>
  }
  
  var service: Service?
  let disposeBag = DisposeBag()
  let keywordSubject = PublishSubject<[Keyword]>()
  let isLoadingSubject = PublishSubject<Bool>()
  
  init(service: Service) {
    self.service = service
  }
  
  func transform(input: Input) -> Output {
    input.viewWillAppearObservable.subscribe(onNext: { [weak self] (_) in
      guard let `self` = self else {
        return
      }
      
      self.isLoadingSubject.onNext(true)
      
      self.service!.getKeywords()
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] (keywords) in
          self?.isLoadingSubject.onNext(false)
          guard let keywords = keywords else {
            return
          }
          
          self?.keywordSubject.onNext(keywords)
        })
        .disposed(by: self.disposeBag)
    })
    .disposed(by: self.disposeBag)
    
    return Output(isLoadingObservable: self.isLoadingSubject.asObservable(),
                  keywordsObservable: self.keywordSubject.asObservable())
  }
}
