//
//  NSAttributedString+Extension.swift
//  TikiHomeAssignment
//
//  Created by Phuc Hoang on 7/2/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import Foundation
import UIKit

extension String {
  func height(withConstrainedWidth width: CGFloat) -> CGFloat {
    let font = UIFont.systemFont(ofSize: 14)
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
    return ceil(boundingBox.height)
  }
  
  func width(withConstrainedHeight height: CGFloat) -> CGFloat {
    let font = UIFont.systemFont(ofSize: 14)
    let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font] ,context: nil)
    return ceil(boundingBox.width)
  }
  
  func balanceLines() -> CGFloat {
    let height: CGFloat = 35
    var preferWidth = self.width(withConstrainedHeight: height)
    var preferHeight = self.height(withConstrainedWidth: preferWidth)
    while (height > preferHeight) {
      preferWidth *= 0.9
      preferHeight = self.height(withConstrainedWidth: preferWidth * 0.9)
    }
    preferWidth /= 0.9
    preferHeight = self.height(withConstrainedWidth: preferWidth)
    return preferWidth
  }
}

extension UITextView {
  
}
