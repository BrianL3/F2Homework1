//
//  AuthorTimeline.swift
//  TweetFeller
//
//  Created by Brian Ledbetter on 1/8/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

import Foundation
import UIKit

class AuthorTimeline: UIViewController, UITableViewDelegate, UITableViewDataSource, UIContentContainer {
  var tweets = [Tweet]()
  var authorInFocus : String?
  @IBOutlet weak var tableView: UITableView!
  var twitterService = TwitterService()
  var authorsTweet : Tweet?
  
  @IBOutlet weak var headlineView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // set yo delegate and datasources
    tableView.delegate = self
    tableView.dataSource = self
    // set yo tweetnib
    self.tableView.registerNib(UINib(nibName: "TweetCellView", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TweetCell")
    self.tableView.estimatedRowHeight = 120
    self.tableView.rowHeight = UITableViewAutomaticDimension
    // setting up the header of the table to load from the TweetHeader nib
    let headerArray = NSBundle.mainBundle().loadNibNamed("TweetHeader", owner: self, options: nil)
    let headerView = headerArray.first as TweetHeader
    self.tableView.tableHeaderView?.addSubview(headerView)
    headerView.profilePictureButton.setBackgroundImage(authorsTweet?.image, forState: .Normal)
    // go fetch the timeline to populate the table
    self.twitterService.fetchTimelineForAuthor(authorInFocus!, completionHandler: { (tweets, errorString) -> () in
      if errorString == nil {
        self.tweets = tweets!
        self.tableView.reloadData()
      }else{
        print("tried to fetchTimelineForAuthor " + self.authorInFocus!)
      }
      
    })
    let tweet = self.tweets.first
    headerView.nameLabel?.text = authorsTweet?.author
    headerView.locationLabel?.text = authorsTweet?.userLocation
    if authorsTweet!.timesFavorited != nil {
      headerView.faveCount?.text = String(self.authorsTweet!.timesFavorited!) + " favorites"
    }
    if authorsTweet?.profileUsesBackgroundImage == true {
      twitterService.fetchAuthorBackgroundImage(authorsTweet!, completionHandler: {(image) -> () in
        println("the headerbackground image is being set to ")
        //headerView.backgroundImage?.image = self.tweetInFocus!.backgroundImage?
        headerView.backgroundColor = UIColor(patternImage: image!)
        //  self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png"))
        
        
        //   headerView.backgroundImage?.image = self.tweetInFocus!.backgroundImage!
      })
    }

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
  
  
  // complying to UIContainerView
  override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    self.tableView.tableHeaderView = self.tableView.tableHeaderView

  }
}