//
//  Tweet.swift
//  TweetFeller
//
//  Created by Brian Ledbetter on 1/5/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

import Foundation
import UIKit

class Tweet {
  var text : String = "failed to init"
  var imgURL : NSURL?
  var image : UIImage?
  var user : NSDictionary
  
  init(jsonDict : [String : AnyObject]){
    self.text = jsonDict["text"] as String
    self.user = jsonDict["user"] as NSDictionary
   // if let url = jsonDict["profile_image_url"] as? String{
     // println("????")
      self.imgURL = NSURL(fileURLWithPath: user["profile_image_url"] as String)!
  // }
  }
}