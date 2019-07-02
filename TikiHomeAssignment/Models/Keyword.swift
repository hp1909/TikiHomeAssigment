//
//  Keyword.swift
//  TikiHomeAssignment
//
//  Created by Phuc Hoang on 7/1/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import Foundation

struct Keyword: Codable {
  var keyword: String
  var icon: String
}

struct Keywords: Codable {
  let keywords: [Keyword]?
}
