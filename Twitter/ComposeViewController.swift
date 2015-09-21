//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Eli Tucker on 9/15/15.
//  Copyright (c) 2015 Eli Tucker. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var composeTextField: UITextField!
    
    var tweetActedUpon: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = User.currentUser!
        
        self.nameLabel.text = user.name
        screennameLabel.text = "@" + user.screenname!
        profileImageView.setImageWithURL(user.profileImageUrl)
        
        if tweetActedUpon != nil && tweetActedUpon?.user?.screenname != nil {
            composeTextField.text = "@\(tweetActedUpon!.user!.screenname!) "
        }

        // TODO: Make the composeTextField active to prevent an extra tap for the user.
    }

    @IBAction func sendTweetClicked(sender: AnyObject) {
        let tweetText = composeTextField.text
        
        if tweetText!.characters.count > 140 {
            let alert = UIAlertView(title: "Get Terse", message: "Tweets can only be 140 characters or less.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return
        }
        
        TwitterClient.sharedInstance.postTweet(composeTextField!.text!, inReplyToStatusId: tweetActedUpon?.idStr) { (error) -> () in
            // TODO: Show an error dialog?
            // TODO: Return them back to home timeline
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
