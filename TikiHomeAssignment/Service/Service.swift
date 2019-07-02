//
//  Service.swift
//  TikiHomeAssignment
//
//  Created by Phuc Hoang on 7/1/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import Foundation
import Alamofire

class Service {
  var webAPI: WebAPIProtocol
  init(webAPI: WebAPIProtocol) {
    self.webAPI = webAPI
  }
  
  func getKeywords(completion: @escaping ([Keyword]?) -> Void) {
    let httpRequest = HTTPRequestModel(url: Constants.KEYWORDS_URL)
    self.webAPI.request(httpRequest: httpRequest) { data in
      guard let rawData = data else {
        completion(nil)
        return
      }
      
      let decoder = JSONDecoder()

      do {
        let result = try decoder.decode(Keywords.self, from: rawData)
        completion(result.keywords)
      } catch {
        completion(nil)
        print("unexpected error")
      }
    }
  }
}
