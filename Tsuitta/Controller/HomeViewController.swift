//
//  HomeViewController.swift
//  Tsuitta
//
//  Created by jaco on 2015/12/13.
//  Copyright © 2015年 土門良輔. All rights reserved.
//

import Foundation

class HomeViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        
        if let view = UINib(nibName: "HomeView", bundle: nil).instantiateWithOwner(self, options: nil).first as? HomeView {
            self.view = view
//            view.delegate = self
        }
        
    }
    
}