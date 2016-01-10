//
//  HomeViewController.swift
//  Tsuitta
//
//  Created by jaco on 2015/12/13.
//  Copyright © 2015年 土門良輔. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UITableViewController {
    
    override func loadView() {
        super.loadView()
        
        if let view = UINib(nibName: "TweetTableView", bundle: nil).instantiateWithOwner(self, options: nil).first as? TweetTableView {
            self.view = view
//            view.delegate = self
        }
        
    }
    
    override func viewDidLoad() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
}