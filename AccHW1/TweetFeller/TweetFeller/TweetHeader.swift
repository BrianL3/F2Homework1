//
//  TweetHeader.swift
//  TweetFeller
//
//  Created by Brian Ledbetter on 1/9/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

import UIKit

class TweetHeader: UIView {

  @IBOutlet weak var backgroundImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var profilePictureButton: UIButton!
  @IBOutlet weak var faveCount: UILabel!
  
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  
}
