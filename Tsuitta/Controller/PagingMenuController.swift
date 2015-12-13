//
//  TimeLineViewController.swift
//  Tsuitta
//
//  Created by domon on 2015/12/05.
//  Copyright © 2015年 土門良輔. All rights reserved.
//

import Foundation
import UIKit
import PagingMenuController

class PagingMenuController : UIViewController, PagingMenuControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("fiusdbudsbf")
    }
    
    override func loadView() {
        
        super.loadView()
        
        let view = UINib(nibName: "HomeViewController", bundle: nil).instantiateWithOwner(self, options: nil).first as? HomeViewController
        let viewController = story.instantiateInitialViewController()! as UIViewController
        viewController.title = "Menu title"
        let viewControllers = [viewController]
        
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        
        let options = PagingMenuOptions()
        options.menuHeight = 60
        options.menuDisplayMode = .Standard(widthMode: .Flexible, centerItem: true, scrollingMode: .PagingEnabled)
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
        
    }
    
}