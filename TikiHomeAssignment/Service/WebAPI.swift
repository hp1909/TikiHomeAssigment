//
//  WebAPI.swift
//  TikiHomeAssignment
//
//  Created by Phuc Hoang on 7/1/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol WebAPIProtocol {
  func request(httpRequest: HTTPRequestModel) -> Observable<Data?>
}

class WebAPI: WebAPIProtocol {
  static let shared = WebAPI()
  
  fileprivate init() {}
  
  func request(httpRequest: HTTPRequestModel) -> Observable<Data?> {
    return Observable.create { observer in
      let request = Alamofire.SessionManager.default.request(httpRequest.url, method: httpRequest.method)
        .validate()
        .responseJSON { response in
          switch response.result {
          case .success(_):
            observer.onNext(response.data)
            
          case .failure(let error):
            print("Error: \(error)")
            observer.onError(error)
          }
      }
      
      return Disposables.create {
        request.cancel()
      }
    }
  }
}
