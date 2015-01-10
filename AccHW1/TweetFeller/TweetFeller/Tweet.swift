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
  var user : [String : AnyObject]
  var author : String = "Anonymous"
  var id : String?
  var creationData : String?
  var authorID : String?
  var timesFavorited : Int?
  var userLocation : String?
  var profileUsesBackgroundImage : Bool?
  var backgroundImgURL : NSURL?
  var backgroundImage : UIImage?
  
  init(jsonDict : [String : AnyObject]){
    self.text = jsonDict["text"] as String
    self.user = jsonDict["user"] as Dictionary
   // if let url = jsonDict["profile_image_url"] as? String{
     // println("????")
    self.imgURL = NSURL(string: self.user["profile_image_url"] as String!)
   // self.image = UIImage(data: NSData(contentsOfURL: NSURL(string: user["profile_image_url"] as String!)!)!)
      //NSURL(fileURLWithPath: user["profile_image_url"] as String)!
  // }
    self.author = user["name"] as String!
    self.id = jsonDict["id_str"] as String!
    if jsonDict["created_at"] != nil {
      self.creationData = jsonDict["created_at"] as String!
    }
    self.authorID = user["id_str"] as String!
    if jsonDict["user"] != nil {
      self.timesFavorited = self.user["favourites_count"] as? Int
      self.userLocation = self.user["location"] as? String
      self.profileUsesBackgroundImage = self.user["profile_use_background_image"] as? Bool
      if profileUsesBackgroundImage == true {
        self.backgroundImgURL = NSURL(string: self.user["profile_banner_url"] as String!) as NSURL!
      }
    }
    
  }
}