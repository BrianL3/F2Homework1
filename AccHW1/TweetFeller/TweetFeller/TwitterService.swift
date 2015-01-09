//
//  TwitterService.swift
//  TweetFeller
//
//  Created by Brian Ledbetter on 1/7/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

import Foundation
import Accounts
import Social

class TwitterService {
  
  var accountID : ACAccountType?
  var twitterAccounts = [AnyObject]()
  var imageQueue = NSOperationQueue()
  
  init(){
  }
  
  func prepAccounts() -> (){
    if twitterAccounts.isEmpty {
      let accountStore = ACAccountStore()
      self.accountID = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
      accountStore.requestAccessToAccountsWithType(self.accountID, options: nil) { (granted, error) -> Void in
        if granted {
          let accounts = accountStore.accountsWithAccountType(self.accountID)
          let myAccount = accounts.first as ACAccount
          self.twitterAccounts.append(accounts.first as ACAccount)
        }
      }
    }else{
      println("prepAccounts says: the user has not logged into Twitter on this device")
    }
  }
  // divided this function out in case twitter updates their API.  One quick change should change all API calls to 1.next.
  func prepRequest(requestSuffix : String) -> (NSURL?) {
    let requestURL = NSURL(string: "https://api.twitter.com/1.1/" + requestSuffix)
    return requestURL
  }
  
  func fetchHomeTimeline( completionHandler : ([Tweet]?, String?) -> ()){
    if twitterAccounts.isEmpty {
      let accountStore = ACAccountStore()
      self.accountID = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
      accountStore.requestAccessToAccountsWithType(self.accountID, options: nil) { (granted, error) -> Void in
        if granted {
          let accounts = accountStore.accountsWithAccountType(self.accountID)
          let myAccount = accounts.first as ACAccount
          self.twitterAccounts.append(accounts.first as ACAccount)
          if !self.twitterAccounts.isEmpty {
            let twitterAccount = self.twitterAccounts.first as ACAccount
            let requestURL = self.prepRequest("statuses/home_timeline.json")
            let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
            twitterRequest.account = twitterAccount
            twitterRequest.performRequestWithHandler() { (jsonData, response, error) -> Void in
              switch response.statusCode {
              case 200...299:
                println(response.statusCode)
                var errorCode : NSError?
                if let JSONArray = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &errorCode) as [AnyObject]? {
                  //working through all objects in the JSON array
                  var tweets = [Tweet]()
                  for jsonObject in JSONArray{
                    if let jsonDictionary = jsonObject as? [String : AnyObject] {
                      let tweet = Tweet(jsonDict: jsonDictionary)
                      tweets.append(tweet)
                      
                    }else{ println("failed to iterate through jsonArray") }
                  }
                  NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    completionHandler(tweets, nil)
                  })
                }else{ println("failed to serialize JSON blob into array") }
              case 300...399:
                var errorResponse = "Error, Code: " + String(response.statusCode)
                completionHandler(nil, errorResponse)
              case 400...499:
                var errorResponse = "Error, Code: " + String(response.statusCode)
                completionHandler(nil, errorResponse)
              default:
                var errorResponse = "Error, Code: " + String(response.statusCode)
                completionHandler(nil, errorResponse)        }
            }
          }else{
            println("prepAccount in TwitterService failed")
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
  
  func fetchTimelineForAuthor(authorID : String, completionHandler : ([Tweet]?, String?) -> ()){
            let twitterAccount = self.twitterAccounts.first as ACAccount
    //statuses/user_timeline.json?username (Links to an external site.)=\
            let requestURL = self.prepRequest("statuses/user_timeline.json?user_id=" + authorID)
            let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
            twitterRequest.account = twitterAccount
            twitterRequest.performRequestWithHandler() { (jsonData, response, error) -> Void in
              switch response.statusCode {
              case 200...299:
                println(response.statusCode)
                var errorCode : NSError?
                if let JSONArray = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &errorCode) as [AnyObject]? {
                  //working through all objects in the JSON array
                  var tweets = [Tweet]()
                  for jsonObject in JSONArray{
                    if let jsonDictionary = jsonObject as? [String : AnyObject] {
                      let tweet = Tweet(jsonDict: jsonDictionary)
                      tweets.append(tweet)
                      
                    }else{ println("failed to iterate through jsonArray") }
                  }
                  NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    completionHandler(tweets, nil)
                  })
                }else{ println("failed to serialize JSON blob into array") }
              case 300...399:
                var errorResponse = "Error, Code: " + String(response.statusCode)
                completionHandler(nil, errorResponse)
              case 400...499:
                var errorResponse = "Error, Code: " + String(response.statusCode)
                completionHandler(nil, errorResponse)
              default:
                var errorResponse = "Error, Code: " + String(response.statusCode)
                completionHandler(nil, errorResponse)        }
            }

    }

  
  
  func fetchStatus(basicTweet : Tweet, tweetID : String, completionHandler : (Tweet?, String?) -> ()){
    let twitterAccount = self.twitterAccounts.first as ACAccount
    let requestURL = self.prepRequest("statuses/show.json?id=" + tweetID)
    let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
    twitterRequest.account = twitterAccount
    twitterRequest.performRequestWithHandler() { (jsonData, response, error) -> Void in
      switch response.statusCode {
      case 200...299:
        var errorCode : NSError?
        if let JSONDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &errorCode) as [String : AnyObject]? {
          basicTweet.text = JSONDictionary["text"] as String
          basicTweet.creationData = JSONDictionary["created_at"] as? String
          //working through all objects in the JSON array
          // ??
          // for jsonObject in JSONArray{
          //  if let jsonDictionary = jsonObject as? [String : AnyObject] {
          ////      let enhancedTweet = Tweet(jsonDict: jsonDictionary)
          //   }
          //  }
          completionHandler(basicTweet, nil)
        }else{ println("failed to serialize JSON blob into array") }
      case 300...399:
        var errorResponse = "Error, Code: " + String(response.statusCode)
        completionHandler(nil, errorResponse)
      case 400...499:
        var errorResponse = "Error, Code: " + String(response.statusCode)
        completionHandler(nil, errorResponse)
      default:
        var errorResponse = "Error, Code: " + String(response.statusCode)
        completionHandler(nil, errorResponse)        }
    }
  }
  
  
  
  func fetchAuthorImage(tweet: Tweet, completionHandler: (UIImage?) ->()){
    if let imageURL = tweet.imgURL {
      //self.imageQueue.maxConcurrentOperationCount = 1  (uncomment to make this a serial queue)
      self.imageQueue.addOperationWithBlock({ () -> Void in
        if let imageData = NSData(contentsOfURL: imageURL) {
          tweet.image = UIImage(data: imageData)
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            completionHandler(tweet.image)
          })
          
          //return tweet.image!
          //        cell.tweetImageView.image = tweet.image
        }
        
      })
    }
  }

}