//
//  WebAPITests.swift
//  TikiHomeAssignmentTests
//
//  Created by Phuc Hoang on 7/3/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import Foundation
import RxSwift
import Quick
import Nimble
import Mockingjay
@testable import TikiHomeAssignment

class WebAPISpec: QuickSpec {
  override func spec() {
    describe("WebAPI") {
      var webAPI: WebAPIProtocol?
      var disposeBag: DisposeBag?
      var httpRequest: HTTPRequestModel?
      
      beforeEach {
        webAPI = WebAPI.shared
        disposeBag = DisposeBag()
        httpRequest = HTTPRequestModel(url: Constants.KEYWORDS_URL)
      }
      
      afterEach {
        self.removeAllStubs()
      }
      
      context("get data from url successful") {
        var expectedData: Data?
        
        beforeEach {
          self.stubGetKeywords(withJsonData: "keywords_success")
          
          webAPI!.request(httpRequest: httpRequest!).subscribe(onNext: { result in
            expectedData = result
          }).disposed(by: disposeBag!)
        }
        
        it("should return valid data") {
          expect(expectedData).toEventuallyNot(beNil())
        }
      }
      
      context("get data from url fail") {
        var expectedData: Data?
        
        beforeEach {
          self.stubGetKeywords(withJsonData: "keywords_fail")
          
          webAPI!.request(httpRequest: httpRequest!).subscribe(onNext: { result in
            expectedData = result
          }).disposed(by: disposeBag!)
        }
        
        it("should return nil") {
          expect(expectedData).toEventually(beNil())
        }
      }
    }
  }
}
