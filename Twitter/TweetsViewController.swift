//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Eli Tucker on 9/14/15.
//  Copyright (c) 2015 Eli Tucker. All rights reserved.
//

import UIKit
import AFNetworking

enum ViewMode {
    case Timeline, Mentions, Profile, OtherProfile
}


class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetCellDelegate  {

    var viewMode: ViewMode = ViewMode.Timeline {
        didSet {
            print("new viewMode: \(viewMode)")
            if viewMode == ViewMode.Profile {
                selectedUser = nil
            }
            loadTweets()
        }
    }
    var tweets: [Tweet]?
    var selectedUser: User?
    
    // for the TweetCellDelegate action replyTo
    var lastActedOnTweet: Tweet?
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        
        setupRefreshControl()
        loadTweets()
    }
    
    // Hack to use Apple's standard UIRefreshControl in a UIViewController instead of a UITableViewController.
    // See https://guides.codepath.com/ios/Table-View-Guide#implementing-pull-to-refresh-with-uirefreshcontrol
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "loadTweets", forControlEvents: UIControlEvents.ValueChanged)
        let dummyTableViewController = UITableViewController()
        dummyTableViewController.tableView = tableView
        dummyTableViewController.refreshControl = refreshControl
    }

    func viewName() {
        switch viewMode {
            case ViewMode.Profile: "Profile"
            case ViewMode.Mentions: "Mentions"
            case ViewMode.Timeline: "Timeline"
            case ViewMode.OtherProfile: "-"
        }
    }
    
    func hasHeaderSection() -> Bool {
        if viewMode == ViewMode.Profile || viewMode == ViewMode.OtherProfile {
            return true
        }
        return false
    }
    
    func loadTweets() {
        func loadAndUpdate(title: String, tweets: [Tweet]?, error: ErrorType?) {
            print("Got \(tweets?.count) tweets to show in your timeline")
            
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            
            self.navigationController?.navigationBar.topItem?.title = title
        }
        
        if viewMode == ViewMode.Mentions {
            print("Loading mentions timeline!")
            TwitterClient.sharedInstance.mentionsTimelineWithParams(nil, completion: { (tweets, error) -> () in
                loadAndUpdate("Mentions", tweets: tweets, error: error)
            })
        } else if viewMode == ViewMode.Profile {
            TwitterClient.sharedInstance.userTimelineWithParams(User.currentUser!.screenname!, completion: { (tweets, error) -> () in
                loadAndUpdate("Profile", tweets: tweets, error: error)
            })
        } else if viewMode == ViewMode.OtherProfile {
            TwitterClient.sharedInstance.userTimelineWithParams(selectedUser!.screenname!, completion: { (tweets, error) -> () in
                loadAndUpdate("Profile", tweets: tweets, error: error)
            })
        } else {
            TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
                loadAndUpdate("Timeline", tweets: tweets, error: error)
            })
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hasHeaderSection() && section == 0 {
            return 1
        }
        
        if let tweets = tweets {
            return tweets.count
        }
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if hasHeaderSection() {
            return 2
        }
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if hasHeaderSection() && indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("HeaderTableViewCell") as! HeaderTableViewCell
            cell.user = selectedUser != nil ? selectedUser : User.currentUser
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as! TweetCell
            
            let tweet = tweets?[indexPath.row]
            if let tweet = tweet {
                cell.tweet = tweet
                cell.delegate = self
            }
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("User selected a row!")

        if hasHeaderSection() && indexPath.section == 0 {
            return
        }
        
        let tweet = tweets?[indexPath.row]
        if let tweet = tweet {
            selectedUser = tweet.user!
            viewMode = ViewMode.OtherProfile
            loadTweets()
        }
    }
    
    func replyTo(tweet: Tweet) {
        lastActedOnTweet = tweet
        performSegueWithIdentifier("composeSegue", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "composeSegue") {
            let viewController = segue.destinationViewController as! ComposeViewController
            viewController.tweetActedUpon = self.lastActedOnTweet
        }

    }
}
