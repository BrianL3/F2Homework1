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
  var authorButton : UIButton?
  @IBOutlet weak var tableView: UITableView!
  
  
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
    self.authorButton = headerView.profilePictureButton
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
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as TweetViewCell
    let tweet = tweetInFocus
    // vvv there is NO image currently with the tweet, go get the image somehow (2 options)
    if tweet!.image == nil{
      // vvv there is NO indexForKey, go get the image and populate the cache
      if self.twitterService!.imageCache.indexForKey(tweet!.imgURL!) == nil {
        twitterService!.fetchAuthorImage(tweet!, completionHandler: { (imageFromHandler) -> () in
          tweet!.image = imageFromHandler?
          // vvv check if we got an image at all - if we did, cache that bad boy
          if imageFromHandler != nil{
            self.twitterService!.imageCache.updateValue(tweet!.image!, forKey: tweet!.imgURL!)
            cell.authorImage?.image = self.twitterService!.imageCache[tweet!.imgURL!]
          }
        })
        // vvv there IS an indexForKey, so grab the image from the cache
      }else{
        if tweet!.imgURL != nil {
          tweet!.image = self.twitterService!.imageCache[tweet!.imgURL!]
          cell.authorImage?.image = tweet!.image
        }
      }
      // vvv there is a image for the tweet (we are scrolling over an area already seen)
    }else{
      cell.authorImage?.image = tweet!.image
    }
    
    cell.tweetText?.text = tweet!.text
    cell.authorName?.text = "@" + tweet!.author + " tweeted:"
    return cell
  }
  
  // having trouble making the cells static, so we just return 1
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  // moving to the next view controller
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let authTimelineVC = self.storyboard?.instantiateViewControllerWithIdentifier("AUTHTIME_VC") as AuthorTimeline
    authTimelineVC.twitterService = self.twitterService!
    authTimelineVC.authorInFocus = self.tweetInFocus!.authorID
    authTimelineVC.authorsTweet = self.tweetInFocus
    self.navigationController?.pushViewController(authTimelineVC, animated: true)
  }
  // can't figure out how to set the outlet properly, as the button actually belongs to the TweetHeader xib
  @IBAction func authorProfileButtonPress(sender: UIButton){
    let authTimelineVC = self.storyboard?.instantiateViewControllerWithIdentifier("AUTHTIME_VC") as AuthorTimeline
    authTimelineVC.twitterService = self.twitterService!
    authTimelineVC.authorInFocus = self.tweetInFocus!.authorID
    authTimelineVC.authorsTweet = self.tweetInFocus
    self.navigationController?.pushViewController(authTimelineVC, animated: true)
  }
}