//
//  WebAPI.swift
//  TikiHomeAssignment
//
//  Created by Phuc Hoang on 7/1/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import Foundation
import Alamofire

protocol WebAPIProtocol {
  func request(httpRequest: HTTPRequestModel, completion: @escaping (Data?) -> Void)
}

class WebAPI: WebAPIProtocol {
  static let shared = WebAPI()
  
  fileprivate init() {}
  
  func request(httpRequest: HTTPRequestModel, completion: @escaping (Data?) -> Void) {
    Alamofire.request(httpRequest.url, method: httpRequest.method)
      .validate()
      .responseJSON { response in
        switch response.result {
        case .success(_):
          completion(response.data)
          return

        case .failure(let error):
          print("Error: \(error)")
          completion(nil)
          return
        }
    }
  }
}
