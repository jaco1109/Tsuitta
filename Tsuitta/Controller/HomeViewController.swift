//
//  HomeViewController.swift
//  Tsuitta
//
//  Created by jaco on 2015/12/13.
//  Copyright © 2015年 土門良輔. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var tweets: [TWTRTweet] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        
        loadTweets()
        
        APILocator.sharedInstance.search.users("Twitter API") {
            users in
            users.forEach({ (user) -> () in
                print("-------------")
                print(user)
            })
        }
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func loadTweets() {
        APILocator.sharedInstance.search.images("d") {
            tweets in
            for tweet in tweets {
                self.tweets.append(tweet)
            }
        }
        APILocator.sharedInstance.tweet.single("678556859976933376", callback: { (tweets) -> Void in
            self.tweets.append(tweets)
        })
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of Tweets.
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TweetTableViewCell
        let tweet = tweets[indexPath.row]
        cell.label.text = tweet.text
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let tweet = tweets[indexPath.row]
        
        return TWTRTweetTableViewCell.heightForTweet(tweet, width: self.view.bounds.width)
    }
    
}