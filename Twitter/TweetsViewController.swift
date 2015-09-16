//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Eli Tucker on 9/14/15.
//  Copyright (c) 2015 Eli Tucker. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDataSource {

    var tweets: [Tweet]?
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
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

    func loadTweets() {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            println("Got \(tweets?.count) tweets to show in your timeline")

            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        }
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as! TweetCell
        
        var tweet = tweets?[indexPath.row]
        if let tweet = tweet {
//            cell.nameLabel.text = tweet.user?.name
//            cell.screennameLabel.text = tweet.user?.screenname
//            cell.profileImageView.setImageWithURL(tweet.user?.profileImageUrl)
//            cell.tweetTextLabel.text = tweet.text
            cell.tweet = tweet
        }
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
