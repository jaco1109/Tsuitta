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

class PagingController: UIViewController, PagingMenuControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("fiusdbudsbf")
    }
    
    override func loadView() {
        
        super.loadView()
        
//        //let view = UINib(nibName: "HomeViewController", bundle: nil).instantiateWithOwner(self, options: nil).first as! HomeViewController
//        let view = HomeViewController()
//        
//        let viewControllers: [UIViewController] = [view]
//        
//        let options = PagingMenuOptions()
//        options.menuHeight = 60
//        options.menuDisplayMode = .Standard(widthMode: .Flexible, centerItem: true, scrollingMode: .PagingEnabled)
////        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
//
//        let pagingMenuController = PagingMenuController(viewControllers: viewControllers, options: options)
//        pagingMenuController.delegate = self
//        pagingMenuController.setup(viewControllers: viewControllers, options: options)
        
        view.backgroundColor = UIColor.whiteColor()
        
        let viewController1 = HomeViewController()
        viewController1.title = "ホーム"
        
        let viewController2 = HomeViewController()
        viewController2.title = "メンション"
        
        let viewController3 = HomeViewController()
        viewController3.title = "メッセージ"
        
        let viewControllers = [viewController1, viewController2, viewController3]
        
        let screenW = UIScreen.mainScreen().bounds.size.width
        
        let options = PagingMenuOptions()
        options.menuHeight = 48
        options.menuItemMargin = 10
        options.menuItemMode = PagingMenuOptions.MenuItemMode.Underline(height: 3, color: ConstantColor.black(), horizontalPadding: 0, verticalPadding: 0)
        options.menuDisplayMode = .Infinite(widthMode: PagingMenuOptions.MenuItemWidthMode.Fixed(width: screenW / 100 * 30))
        options.font = UIFont.boldSystemFontOfSize(16)
        options.selectedFont = UIFont.boldSystemFontOfSize(16)
        options.textColor = ConstantColor.gray()
        options.selectedTextColor = ConstantColor.black()
        
        let pagingMenuController = PagingMenuController(viewControllers: viewControllers, options: options)
        pagingMenuController.view.frame.origin.y += 20
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMoveToParentViewController(self)

        
    }
    
}