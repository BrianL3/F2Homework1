//
//  AuthorTimeline.swift
//  TweetFeller
//
//  Created by Brian Ledbetter on 1/8/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

import Foundation
import UIKit

class AuthorTimeline: UIViewController, UITableViewDelegate, UITableViewDataSource{
  var tweets = [Tweet]()
  var authorInFocus : String?
  @IBOutlet weak var tableView: UITableView!
  var twitterService = TwitterService()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    self.tableView.registerNib(UINib(nibName: "TweetCellView", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TweetCell")
    self.twitterService.fetchTimelineForAuthor(authorInFocus!, completionHandler: { (tweets, errorString) -> () in
      if errorString == nil {
        self.tweets = tweets!
        self.tableView.reloadData()
      }else{
        print("tried to fetchTimelineForAuthor " + self.authorInFocus!)
      }
      
    })
  }
  
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as TweetViewCell
    let tweet = tweets[indexPath.row]
    
    if tweet.image == nil{
      twitterService.fetchAuthorImage(tweet, completionHandler: { (image) -> () in
        tweet.image = image?
        self.tableView.reloadData()
      })
    }else{
      cell.authorImage?.image = tweet.image
    }
    
    cell.tweetText?.text = tweet.text
    cell.authorName?.text = "@" + tweet.author + " tweeted:"
    return cell  }
}