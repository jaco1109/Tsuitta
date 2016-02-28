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
import WebImage

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
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
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
    
    // TODO:ツイート文章を上寄せにする
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TweetTableViewCell
        let tweet = tweets[indexPath.row]
        cell.configure(tweet)
        
        return cell
    }
    
}