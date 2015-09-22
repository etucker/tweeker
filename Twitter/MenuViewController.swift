//
//  MenuViewController.swift
//  Twitter
//
//  Created by Eli Tucker on 9/20/15.
//  Copyright © 2015 Eli Tucker. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var tweetsNavigationViewController: UIViewController!

    var viewControllers: [UIViewController] = []
    
    var hamburgerViewController: HamburgerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        func createNavigationViewControllerForMode(viewMode: ViewMode) -> UINavigationController {
            let navigationViewController = storyboard.instantiateViewControllerWithIdentifier("NavigationTweetsViewController") as! UINavigationController
            let tweetsViewController = navigationViewController.viewControllers[0] as! TweetsViewController
            tweetsViewController.viewMode = viewMode
            return navigationViewController
        }

        viewControllers.append(createNavigationViewControllerForMode(ViewMode.Timeline))
//        viewControllers.append(createNavigationViewControllerForMode(ViewMode.Mentions))
//        viewControllers.append(createNavigationViewControllerForMode(ViewMode.Profile))
        
        hamburgerViewController?.contentViewController = viewControllers[0]
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        //        return viewControllers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
        
        let titles = ["Timeline", "Mentions", "Profile"]
        cell.menuTitleLabel.text = titles[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
//        hamburgerViewController?.contentViewController = viewControllers[indexPath.row]
        hamburgerViewController?.contentViewController = viewControllers[0]
        
        let navigationViewController = viewControllers[0] as! UINavigationController
        let tweetsViewController = navigationViewController.viewControllers[0] as! TweetsViewController
        let viewModes = [ViewMode.Timeline, ViewMode.Mentions, ViewMode.Profile]
        tweetsViewController.viewMode = viewModes[indexPath.row]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
