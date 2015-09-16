//
//  TweetCell.swift
//  Twitter
//
//  Created by Eli Tucker on 9/14/15.
//  Copyright (c) 2015 Eli Tucker. All rights reserved.
//

import UIKit
import AFNetworking

protocol TweetCellDelegate {
    func replyTo(tweet: Tweet)
}

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            updateView()
        }
    }
    
    var delegate: TweetCellDelegate?
    
    func updateView() {
        nameLabel.text = tweet.user?.name
        screennameLabel.text = "@" + tweet.user!.screenname!
        timeLabel.text = tweet.createdAt?.shortTimeAgoSinceNow()
        tweetTextLabel.text = tweet.text
        profileImageView.setImageWithURL(tweet.user!.profileImageUrl)
        
        retweetButton.setTitle(String(tweet.retweetCount!), forState: UIControlState.Normal)
        favoriteButton.setTitle(String(tweet.favoriteCount!), forState: UIControlState.Normal)
        
        if tweet.userRetweeted {
            retweetButton.setImage(UIImage(named: "retweet_on"), forState: UIControlState.Normal)
        } else {
            retweetButton.setImage(UIImage(named: "retweet"), forState: UIControlState.Normal)
        }
        
        if tweet.userFavorited {
            favoriteButton.setImage(UIImage(named: "favorite_on"), forState: UIControlState.Normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favorite"), forState: UIControlState.Normal)
        }
    }
    
    @IBAction func onFavorited(sender: AnyObject) {
        TwitterClient.sharedInstance.favoriteTweet(tweet.idStr!, completion: { (error) -> () in
            if error == nil {
                self.tweet.userFavorited = true
                self.tweet.favoriteCount! += 1
                self.updateView()
            }
        })
    }
    
    @IBAction func onRetweeted(sender: AnyObject) {
        TwitterClient.sharedInstance.retweetTweet(tweet.idStr!, completion: { (error) -> () in
            if error == nil {
                self.tweet.userRetweeted = true
                self.tweet.retweetCount! += 1
                self.updateView()
            }
        })
    }
    
    @IBAction func onReply(sender: AnyObject) {
        if let delegate = delegate {
            delegate.replyTo(tweet)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
