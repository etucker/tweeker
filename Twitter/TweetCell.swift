//
//  TweetCell.swift
//  Twitter
//
//  Created by Eli Tucker on 9/14/15.
//  Copyright (c) 2015 Eli Tucker. All rights reserved.
//

import UIKit
import AFNetworking

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
