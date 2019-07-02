//
//  Service.swift
//  TikiHomeAssignment
//
//  Created by Phuc Hoang on 7/1/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class Service {
  var webAPI: WebAPIProtocol
  init(webAPI: WebAPIProtocol) {
    self.webAPI = webAPI
  }
  
  func getKeywords() -> Observable<[Keyword]?> {
    let httpRequest = HTTPRequestModel(url: Constants.KEYWORDS_URL)
    return self.webAPI.request(httpRequest: httpRequest)
      .flatMap{ (data) -> Observable<[Keyword]?> in
        guard let rawData = data else {
          return Observable.just(nil)
        }
        
        let result = ModelParser<Keywords>.parse(data: rawData)
        return Observable.just(result?.keywords)
      }
  }
}
