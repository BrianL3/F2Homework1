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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    // begin Twitter API call
    let accountStore = ACAccountStore()
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted : Bool, error : NSError!) -> Void in
      if granted {
        let accounts = accountStore.accountsWithAccountType(accountType)
        if !accounts.isEmpty {
          let twitterAccount = accounts.first as ACAccount
          let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
          let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
          twitterRequest.account = twitterAccount
          twitterRequest.performRequestWithHandler() { (jsonData, response, error) -> Void in
            switch response.statusCode {
            case 200...299:
              println(response.statusCode)
              var errorCode : NSError?
              if let JSONArray = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &errorCode) as [AnyObject]? {
                //working through all objects in the JSON array
                for jsonObject in JSONArray{
                  if let jsonDictionary = jsonObject as? [String : AnyObject] {
                    let tweet = Tweet(jsonDict: jsonDictionary)
                    self.tweets.append(tweet)
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                      self.tableView.reloadData()
                    })
                  }else{ println("failed to iterate through jsonArray") }
                }
              }else{ println("failed to serialize JSON blob into array") }
            case 300...399:
              println(response.statusCode)
              println("Error")
            case 400...499:
              println(response.statusCode)
              println("Error")
            default:
              println("got a bad, non-500, non-400 response.")
            }
          
          }
        }
      }
    }
    /*  ==== for use in testing against locally-stored Twitter-formatted .json files ====
    if let jsonPath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json"){
      if let jsonData = NSData(contentsOfFile: jsonPath) as NSData?{

      }else{ println("failed to load path into NSData") }
    }else{ println("failed to get JSON path") }
    */
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
  /*
  Display and Configuration functions
  */

}

