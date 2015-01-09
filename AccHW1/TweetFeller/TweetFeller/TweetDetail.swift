//
//  TweetDetail.swift
//  TweetFeller
//
//  Created by Brian Ledbetter on 1/8/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

import Foundation
import UIKit

class TweetDetail: UIViewController, UITableViewDataSource, UITableViewDelegate {
  var tweetInFocus : Tweet?
  var twitterService : TwitterService?
  
  @IBOutlet weak var tableView: UITableView!
  //@IBOutlet weak var dateLabel: UILabel!
  //@IBOutlet weak var textLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    self.tableView.registerNib(UINib(nibName: "TweetCellView", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TweetCell")

    if twitterService != nil{
      self.twitterService?.fetchStatus(tweetInFocus!, tweetID: tweetInFocus!.id!, completionHandler: { (tweet, errorDescription) -> () in
        self.tweetInFocus = tweet
      })
    }
    //textLabel?.text = tweetInFocus?.text
    //dateLabel?.text = tweetInFocus?.creationData?
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as TweetViewCell
    let tweet = tweetInFocus
    twitterService?.fetchAuthorImage(tweet!, completionHandler: { (image) -> () in
      tweet!.image = image?
      self.tableView.reloadData()
    })
    if tweet!.image != nil{
      cell.authorImage?.image = tweet!.image
    }
    cell.tweetText?.text = tweet!.text
    cell.authorName?.text = "@" + tweet!.author + " tweeted:"
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let authTimelineVC = self.storyboard?.instantiateViewControllerWithIdentifier("AUTHTIME_VC") as AuthorTimeline
    authTimelineVC.twitterService = self.twitterService!
    authTimelineVC.authorInFocus = self.tweetInFocus!.authorID
    self.navigationController?.pushViewController(authTimelineVC, animated: true)
  }
  
}