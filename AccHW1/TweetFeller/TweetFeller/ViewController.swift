//
//  ViewController.swift
//  TweetFeller
//
//  Created by Brian Ledbetter on 1/5/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
  var tweets = [Tweet]()
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    if let jsonPath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json"){
      if let jsonData = NSData(contentsOfFile: jsonPath) as NSData?{
        var errorCode : NSError?
        if let JSONArray = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &errorCode) as [AnyObject]? {
          //working through all objects in the JSON array
          for jsonObject in JSONArray{
            if let jsonDictionary = jsonObject as? [String : AnyObject] {
              let tweet = Tweet(jsonDict: jsonDictionary)
              self.tweets.append(tweet)
            }else{ println("failed to iterate through jsonArray") }
          }
        }else{ println("failed to serialize JSON blob into array") }
      }else{ println("failed to load path into NSData") }
    }else{ println("failed to get JSON path") }
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
    cell.textLabel?.text = tweet.text
    if let url = tweet.imgURL? {
      //var data:NSData = NSData(contentsOfURL: tweet.imgURL!, options: nil, error: nil)!
      //cell.imageView?.image = UIImage(data: data)
    }
    return cell
  }
  /*
  Display and Configuration functions
  */

}

