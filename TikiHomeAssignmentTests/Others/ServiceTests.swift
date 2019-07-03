//
//  ServiceTests.swift
//  TikiHomeAssignmentTests
//
//  Created by Phuc Hoang on 7/3/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxSwift
import Mockingjay
@testable import TikiHomeAssignment

class ServiceSpec: QuickSpec {
  override func spec() {
    describe("Service") {
      var service: ServiceProtocol?
      var disposeBag: DisposeBag?

      beforeEach {
        service = Service(webAPI: WebAPI.shared)
        disposeBag = DisposeBag()
      }
      
      afterEach {
        self.removeAllStubs()
      }
      
      context("get keywords successful") {
        var keywords: [Keyword]?

        beforeEach {
          self.stubGetKeywords(withJsonData: "keywords_success")

          service?.getKeywords().subscribe(onNext: { result in
            keywords = result
          }).disposed(by: disposeBag!)
        }
        
        it("should return valid keywords") {
          expect(keywords).toEventuallyNot(beNil())
          expect(keywords?.count).toEventually(equal(14))
          expect(keywords?.first?.keyword).to(equal("Hello"))
        }
      }
      
      context("get keywords fail") {
        var keywords: [Keyword]?
        
        beforeEach {
          self.stubGetKeywords(withJsonData: "keywords_fail")
          
          service?.getKeywords().subscribe(onNext: { result in
            keywords = result
          }).disposed(by: disposeBag!)
        }
        
        it("should return nil") {
          expect(keywords).toEventually(beNil())
        }
      }
    }
  }
}
