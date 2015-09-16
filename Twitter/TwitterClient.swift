//
//  TwitterClient.swift
//  Twitter
//
//  Created by Eli Tucker on 9/12/15.
//  Copyright (c) 2015 Eli Tucker. All rights reserved.
//

import UIKit

let twitterConsumerKey = "mcvvzgavEV7Gk4xilSKlVaaKu"
let twitterConsumerSecret = "UhIKsnuGdjsYaQyH9TkOw2BHRiyaTLqlwHJIid1TcY4u1kskLd"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {

    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> () ) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                completion(tweets: tweets, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error getting home timeline: \(error)")
                completion(tweets: nil, error: error)
        })
    }
    
    func postTweet(status: String, inReplyToStatusId: String?, completion: (error: NSError?) -> () ) {
        var parameters = ["status": status]
        if inReplyToStatusId != nil {
            parameters["in_reply_to_status_id"] = inReplyToStatusId
        }
        
        POST("1.1/statuses/update.json", parameters: parameters, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                completion(error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error updating status: \(error)")
                completion(error: error)
        })
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // Fetch request token & redirect to auth page.
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            println("got the request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(authURL)
            }) { (error:NSError!) -> Void in
                println("failed to get the request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
        println("Application opened with url \(url)")
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                
                    var user = User(dictionary: response as! NSDictionary)
                    println("user: \(user.name)")
                    User.currentUser = user
                    self.loginCompletion?(user: user, error: nil)
                }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("error getting current user: \(error)")
                    self.loginCompletion?(user: nil, error: error)
                }
            }) { (error: NSError!) -> Void in
                println("failed to receive access token")
                self.loginCompletion?(user: nil, error: error)
            }

    }
}
