//
//  ModelParser.swift
//  TikiHomeAssignment
//
//  Created by Phuc Hoang on 7/2/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import Foundation

struct ModelParser<T: Codable> {
  static func parse(data: Data) -> T? {
    do {
      let decoder = JSONDecoder()
      let result = try decoder.decode(T.self, from: data)
      return result
    } catch {
      return nil
    }
  }
}
