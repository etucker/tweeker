//
//  HeaderTableViewCell.swift
//  Twitter
//
//  Created by Eli Tucker on 9/21/15.
//  Copyright © 2015 Eli Tucker. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    var user: User! {
        didSet {
            updateView()
        }
    }

    func updateView() {
        nameLabel.text = user.name
        profileImageView.setImageWithURL(user.profileImageUrl)
        tweetsLabel.text = "\(user.statusesCount!) tweets"
        followingLabel.text = "\(user.friendsCount!) following"
        followersLabel.text = "\(user.followersCount!) followers"
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
