//
//  AuthorPreviewViewController.swift
//  TweetFeller
//
//  Created by Brian Ledbetter on 1/7/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

import Foundation
import UIKit

class AuthorPreviewViewController: UIViewController {
  var tweetInFocus : Tweet?
  var twitterService : TwitterService?
  
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var textLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if twitterService != nil{
      self.twitterService?.fetchStatus(tweetInFocus!, tweetID: tweetInFocus!.id!, completionHandler: { (tweet, errorDescription) -> () in
        self.tweetInFocus = tweet
      })
    }
    textLabel?.text = tweetInFocus?.text
    dateLabel?.text = tweetInFocus?.creationData?
  }
}