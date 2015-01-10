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
    self.tableView.estimatedRowHeight = 120
    self.tableView.rowHeight = UITableViewAutomaticDimension
    // setting up the header to load from the TweetHeader nib
    let headerArray = NSBundle.mainBundle().loadNibNamed("TweetHeader", owner: self, options: nil)
    let headerView = headerArray.first as TweetHeader
    self.tableView.tableHeaderView?.addSubview(headerView)

    if twitterService != nil{
      self.twitterService?.fetchStatus(tweetInFocus!, tweetID: tweetInFocus!.id!, completionHandler: { (tweet, errorDescription) -> () in
        self.tweetInFocus = tweet
      })
    }
    if tweetInFocus != nil{
      headerView.nameLabel?.text = tweetInFocus?.author
      headerView.profilePictureButton.setBackgroundImage(tweetInFocus?.image, forState: .Normal)
      headerView.locationLabel?.text = tweetInFocus?.userLocation
      if tweetInFocus!.timesFavorited != nil {
        headerView.faveCount?.text = String(self.tweetInFocus!.timesFavorited!) + " favorites"
      }

      if tweetInFocus?.profileUsesBackgroundImage == true {
        twitterService!.fetchAuthorBackgroundImage(tweetInFocus!, completionHandler: {(image) -> () in
          println("this is a placeholder")
          headerView.backgroundColor = UIColor(patternImage: image!)
        })
      }
    }
    //textLabel?.text = tweetInFocus?.text
    //dateLabel?.text = tweetInFocus?.creationData?
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as TweetViewCell
    let tweet = tweetInFocus
    // lazyload for images
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
    authTimelineVC.authorsTweet = self.tweetInFocus
    self.navigationController?.pushViewController(authTimelineVC, animated: true)
  }
  
}