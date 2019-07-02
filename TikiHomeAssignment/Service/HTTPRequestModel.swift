//
//  HTTPRequestModel.swift
//  TikiHomeAssignment
//
//  Created by Phuc Hoang on 7/1/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import Foundation
import Alamofire

class HTTPRequestModel {
  let url: String
  let body: [String: Any]?
  let method: HTTPMethod
  let encoding: JSONEncoding
  
  init(url: String,
       body: [String: Any]? = nil,
       encoding: JSONEncoding = JSONEncoding.default,
       method: HTTPMethod = HTTPMethod.get) {
    self.url = url
    self.body = body
    self.encoding = encoding
    self.method = method
  }
}
