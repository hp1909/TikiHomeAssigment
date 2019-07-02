//
//  UIImageView+Extension.swift
//  TikiHomeAssignment
//
//  Created by Phuc Hoang on 7/1/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

extension UIImageView {
  func loadImage(url: String?) {
    self.image = nil
    if let imageUrl = URL(string: url ?? "") {
      self.image = nil
      self.af_setImage(withURL: imageUrl,
                       placeholderImage: nil,
                       filter: nil,
                       progress: nil,
                       progressQueue: .global(),
                       imageTransition: .noTransition,
                       runImageTransitionIfCached: true)
    }
  }
}
