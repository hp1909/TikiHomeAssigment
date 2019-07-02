//
//  KeywordCollectionViewCell.swift
//  TikiHomeAssignment
//
//  Created by Phuc Hoang on 7/1/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import UIKit

class KeywordCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var thumbnail: UIImageView!
  @IBOutlet weak var keywordLabel: UILabel!
  @IBOutlet weak var keywordContainer: UIView!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.setupViews()
  }
  
  func setupViews() {
    self.keywordContainer.layer.cornerRadius = 5
    self.keywordContainer.clipsToBounds = true
  }
}
