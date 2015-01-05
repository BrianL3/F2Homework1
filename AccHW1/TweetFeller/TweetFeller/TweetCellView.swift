//
//  TweetCellView.swift
//  TweetFeller
//
//  Created by Brian Ledbetter on 1/5/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

import UIKit

class TweetViewCell : UITableViewCell {
  @IBOutlet weak var tweetLabel: UILabel!
  @IBOutlet weak var tweetImage: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: true)
  }
}
