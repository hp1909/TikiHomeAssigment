//
//  ViewModelTests.swift
//  TikiHomeAssignmentTests
//
//  Created by Phuc Hoang on 7/2/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxSwift
import RxTest
@testable import TikiHomeAssignment

fileprivate let keywords: [Keyword] = [
  Keyword(keyword: "keyword1", icon: "url1"),
  Keyword(keyword: "keyword2", icon: "url2"),
  Keyword(keyword: "keyword3", icon: "url3"),
]

class MockSuccessService: ServiceProtocol {
  func getKeywords() -> Observable<[Keyword]?> {
    return Observable.just(keywords)
  }
}

class MockFailService: ServiceProtocol {
  func getKeywords() -> Observable<[Keyword]?> {
    return Observable.just(nil)
  }
}

class ViewModelSpec: QuickSpec {
  override func spec() {
    describe("ViewModel") {
      var viewModel: ViewModel?
      var service: ServiceProtocol?
      var scheduler: TestScheduler!
      var disposeBag: DisposeBag!
      
      beforeEach {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
      }
      
      afterEach {
        service = nil
        viewModel = nil
      }
      
      context("with get keywords success") {
        beforeEach {
          service = MockSuccessService()
          viewModel = ViewModel(service: service!)
        }
        
        it("should emit output with keywords") {
          let keywordsObservable = scheduler.createObserver([Keyword].self)
          let isLoadingObservable = scheduler.createObserver(Bool.self)
          let noDataObservable = scheduler.createObserver(Bool.self)
          
          viewModel!.output.keywordsObservable.bind(to: keywordsObservable).disposed(by: disposeBag)
          viewModel!.output.isLoadingObservable.bind(to: isLoadingObservable).disposed(by: disposeBag)
          viewModel!.output.noDataObservable.bind(to: noDataObservable).disposed(by: disposeBag)
          
          scheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel!.input.viewWillAppearObservable)
            .disposed(by: disposeBag)
          
          scheduler.start()

          expect(isLoadingObservable.events).to(equal([.next(10, true), .next(10, false)]))
          expect(noDataObservable.events).to(equal([.next(10, false)]))
          expect(keywordsObservable.events.count).to(equal(1))
          // Have some problems when compare keywordsObservable.events to .next(10, keywords)
        }
      }
      
      context("with get keywords fail") {
        beforeEach {
          service = MockFailService()
          viewModel = ViewModel(service: service!)
        }
        
        it("should emit output with keywords") {
          let keywordsObservable = scheduler.createObserver([Keyword].self)
          let isLoadingObservable = scheduler.createObserver(Bool.self)
          let noDataObservable = scheduler.createObserver(Bool.self)
          
          viewModel!.output.keywordsObservable.bind(to: keywordsObservable).disposed(by: disposeBag)
          viewModel!.output.isLoadingObservable.bind(to: isLoadingObservable).disposed(by: disposeBag)
          viewModel!.output.noDataObservable.bind(to: noDataObservable).disposed(by: disposeBag)
          
          scheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel!.input.viewWillAppearObservable)
            .disposed(by: disposeBag)
          
          scheduler.start()
          
          expect(isLoadingObservable.events).to(equal([.next(10, true), .next(10, false)]))
          expect(noDataObservable.events).to(equal([.next(10, false)]))
          expect(keywordsObservable.events.count).to(equal(0))
        }
      }
    }
  }
}
