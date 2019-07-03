//
//  TestUtils.swift
//  TikiHomeAssignmentUITests
//
//  Created by Phuc Hoang on 7/3/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import Foundation
import Mockingjay
import KIF_Quick
import Nimble
@testable import TikiHomeAssignment

extension KIFSpec {
  func stubGetKeywords(withJsonData jsonFileName: String) {
    let url = Bundle(for: type(of: self)).url(forResource: jsonFileName, withExtension: "json")!
    let data = try! Data(contentsOf: url)
    self.stub(http(.get, uri: Constants.KEYWORDS_URL), jsonData(data))
  }
}
