//
//  HomeView.swift
//  Tsuitta
//
//  Created by jaco on 2016/03/13.
//  Copyright © 2016年 土門良輔. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit
import WebImage

class HomeView: UIView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    private let cellIdentifier: String = "HomeViewCell"
    private var tweets: [TWTRTweet]?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    func setUp(tweets: [TWTRTweet]) {
        self.tweets = tweets
        self.tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tweets = self.tweets else {
            return 0
        }
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = UINib(nibName: "HomeViewCell", bundle: nil).instantiateWithOwner(self, options: nil).first as? HomeViewCell else {
            return UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        guard let tweets = self.tweets else {
            return UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        
        let tweet = tweets[indexPath.row]
        cell.configure(tweet)
        return cell
        
    }

}