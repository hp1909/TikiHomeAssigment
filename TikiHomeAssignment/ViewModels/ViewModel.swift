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
  
  var input : Input { get }
  var output : Output { get }
}

class ViewModel: ViewModelProtocol {
  var input: ViewModel.Input
  var output: ViewModel.Output
  
  struct Input {
    let viewWillAppearObservable: AnyObserver<Void>
  }
  
  struct Output {
    let isLoadingObservable: Observable<Bool>
    let keywordsObservable: Observable<[Keyword]>
    let noDataObservable: Observable<Bool>
  }
  
  var service: ServiceProtocol?
  
  init(service: ServiceProtocol) {
    self.service = service
    
    let viewWillAppearSubject = PublishSubject<Void>()
    let keywordSubject = PublishSubject<[Keyword]>()
    let isLoadingSubject = PublishSubject<Bool>()
    let noDataSubject = PublishSubject<Bool>()
    let disposeBag = DisposeBag()
    
    viewWillAppearSubject.subscribe(onNext: { (_) in
      isLoadingSubject.onNext(true)
      noDataSubject.onNext(false)
      
      service.getKeywords()
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { (keywords) in
          isLoadingSubject.onNext(false)
          guard let keywords = keywords else {
            return
          }
          
          if keywords.isEmpty {
            noDataSubject.onNext(true)
          }
          
          keywordSubject.onNext(keywords)
        })
        .disposed(by: disposeBag)
    }).disposed(by: disposeBag)
    
    self.input = Input(viewWillAppearObservable: viewWillAppearSubject.asObserver())
    self.output = Output(isLoadingObservable: isLoadingSubject.asObservable(),
                         keywordsObservable: keywordSubject.asObservable(),
                         noDataObservable: noDataSubject.asObservable())
  }
}
