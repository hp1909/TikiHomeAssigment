//
//  MainViewTests.swift
//  TikiHomeAssignmentUITests
//
//  Created by Phuc Hoang on 7/3/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import Foundation
import Quick
import Nimble
import KIF_Quick
import Mockingjay
@testable import TikiHomeAssignment

class MainViewSpec: KIFSpec {
  override func spec() {
    describe("Main view controller") {
      afterEach {
        self.removeAllStubs()
      }
      
      context("with valid keywords response") {
        beforeEach {
          self.stubGetKeywords(withJsonData: "keywords_success")
          self.resetViews()
        }
        
        it("should show keyword collection view") {
          viewTester().usingLabel("keywordLabel")?.waitForView()
          viewTester().usingLabel("keywordCollectionView")?.waitForView()
          viewTester().usingLabel("noDataLabel")?.waitForAbsenceOfView()
          let keywordsCollectionView = viewTester().usingLabel("keywordCollectionView")?.waitForView() as! UICollectionView
          expect(keywordsCollectionView.numberOfItems(inSection: 0)).to(equal(14))
        }
      }
      
      context("with empty keyword response") {
        beforeEach {
          self.stubGetKeywords(withJsonData: "keywords_empty")
          self.resetViews()
        }
        
        it("should show keyword collection view") {
          viewTester().usingLabel("keywordLabel")?.waitForView()
          viewTester().usingLabel("keywordCollectionView")?.waitForAbsenceOfView()
          viewTester().usingLabel("noDataLabel")?.waitForView()
        }
      }
      
      context("with invalid response") {
        beforeEach {
          self.stubGetKeywords(withJsonData: "keywords_fail")
          self.resetViews()
        }
        
        it("should show nothing in collection view") {
          viewTester().usingLabel("keywordLabel")?.waitForView()
          viewTester().usingLabel("keywordCollectionView")?.waitForView()
          viewTester().usingLabel("noDataLabel")?.waitForAbsenceOfView()
          let keywordsCollectionView = viewTester().usingLabel("keywordCollectionView")?.waitForView() as! UICollectionView
          expect(keywordsCollectionView.numberOfItems(inSection: 0)).to(equal(0))
        }
      }
    }
  }
  
  func resetViews() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let rootViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! ViewController
    let service = Service(webAPI: WebAPI.shared)
    let viewModel = ViewModel(service: service)
    rootViewController.viewModel = viewModel
    UIApplication.shared.keyWindow?.rootViewController = rootViewController
  }
}
