//
//  ViewController.swift
//  TweetFeller
//
//  Created by Brian Ledbetter on 1/5/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

import UIKit
import Social
import Accounts

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  var tweets = [Tweet]()
  
  @IBOutlet weak var tableView: UITableView!
  let twitterService = TwitterService()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    self.tableView.registerNib(UINib(nibName: "TweetCellView", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TweetCell")

    // begin Twitter API call
    self.twitterService.fetchHomeTimeline { (tweets, errorString) -> () in
      if errorString == nil {
        self.tweets = tweets!
        self.tableView.reloadData()
      }else{
        println("TwitterService.fetchHomeTimeline did not respond correctly")
      }
    }
  }
  /*
  TableViewDataSource protocol functions
  */
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
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let cell = tableView.cellForRowAtIndexPath(indexPath){
      let tweet = tweets[indexPath.row]
    }
    let tweetVC = self.storyboard?.instantiateViewControllerWithIdentifier("TWEET_VC") as TweetDetail
    tweetVC.twitterService = self.twitterService
    tweetVC.tweetInFocus = self.tweets[indexPath.row]
    self.navigationController?.pushViewController(tweetVC, animated: true)

  }

  /*
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  println(indexPath.row)
  
  let tweetVC = self.storyboard?.instantiateViewControllerWithIdentifier("TWEET_VC") as TweetViewController
  tweetVC.networkController = self.networkController
  tweetVC.tweet = self.tweets[indexPath.row]
  self.navigationController?.pushViewController(tweetVC, animated: true)
  
  }
*/
  
  /*
  Display and Configuration functions
  */

  
  
  /*
  Segues
  */
  /*
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "PREVIEW_AUTHOR"{
      let newDetailController = segue.destinationViewController as AuthorPreviewViewController
      let selectedIndexPath = tableView.indexPathForSelectedRow()
      let selectedTweet : Tweet = tweets[selectedIndexPath!.row]
      newDetailController.tweetInFocus = selectedTweet
      newDetailController.twitterService = self.twitterService
    }
  }
*/
  
  
}

