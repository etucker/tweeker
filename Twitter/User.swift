//
//  User.swift
//  Twitter
//
//  Created by Eli Tucker on 9/14/15.
//  Copyright (c) 2015 Eli Tucker. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: NSURL?
    var tagline: String?
    var followersCount: Int?
    var friendsCount: Int?
    var statusesCount: Int?
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = NSURL(string: dictionary["profile_image_url_https"] as! String)

        tagline = dictionary["description"] as? String
        followersCount = dictionary["followers_count"] as? Int
        friendsCount = dictionary["friends_count"] as? Int
        statusesCount = dictionary["statuses_count"] as? Int
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    let dictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
        
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                let data = try? NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: [])
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
