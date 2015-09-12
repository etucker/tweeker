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
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
}
