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

class ViewController: UIViewController, UITableViewDataSource {
  var tweets = [Tweet]()
  
  @IBOutlet weak var tableView: UITableView!
  let twitterService = TwitterService()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
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
    let cell = tableView.dequeueReusableCellWithIdentifier("TWEET_CELL", forIndexPath: indexPath) as TweetViewCell
    let tweet = tweets[indexPath.row]
    if tweet.image != nil{
      cell.tweetImage?.image = tweet.image!
    }
    cell.tweetLabel?.text = tweet.text
    cell.usernameLabel?.text = "@" + tweet.author + " tweeted:"
    return cell
  }
  /* === in case we want to do something fancy with already clicked-on tweets ===
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let cell = tableView.cellForRowAtIndexPath(indexPath){
      let tweet = tweets[indexPath.row]
    }
  }
*/
  
  /*
  Display and Configuration functions
  */

  
  
  /*
  Segues
  */
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "PREVIEW_AUTHOR"{
      let newDetailController = segue.destinationViewController as AuthorPreviewViewController
      let selectedIndexPath = tableView.indexPathForSelectedRow()
      let selectedTweet : Tweet = tweets[selectedIndexPath!.row]
      newDetailController.tweetInFocus = selectedTweet
      newDetailController.twitterService = self.twitterService
    }
  }
  
  
}

