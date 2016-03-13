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

class HomeViewController: UIViewController {
    
    var tableView: UITableView!
    var tweets: [TWTRTweet]! = []
    
    override func loadView() {
        
        super.loadView()
        if let view = UINib(nibName: "HomeView", bundle: nil).instantiateWithOwner(self, options: nil).first as? HomeView {
            self.view = view
        }
        
    }
    
    // UINibを返すのとregisterNib()するのって何が違うんだろうか
    override func viewDidLoad() {

        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
     
        // TODO: テスト用検索キーワードを直す
        APILocator.sharedInstance.search.images("d") {
            tweets in
            for tweet in tweets {
                self.tweets.append(tweet)
            }
            if let view = self.view as? HomeView {
                view.setUp(tweets)
            }
        }
        
    }
    
}