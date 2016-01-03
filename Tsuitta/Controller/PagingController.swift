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
        
        view.backgroundColor = UIColor.whiteColor()
        
        let homeViewController = HomeViewController()
        let mentionViewController = HomeViewController()
        let messageViewController = HomeViewController()
        
        homeViewController.title = "ホーム"
        mentionViewController.title = "メンション"
        messageViewController.title = "メッセージ"
        
        let topBorder = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 2))
        topBorder.backgroundColor = UIColor.blackColor()
        topBorder.frame.origin.y += UIApplication.sharedApplication().statusBarFrame.size.height
        view.addSubview(topBorder)
        
        let viewControllers = [homeViewController, mentionViewController, messageViewController]
        let options = self.options()
        let pagingMenuController = PagingMenuController(viewControllers: viewControllers, options: options)
        
        pagingMenuController.view.frame.origin.y += UIApplication.sharedApplication().statusBarFrame.size.height + topBorder.frame.size.height
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMoveToParentViewController(self)
        
    }
    
    func options() -> PagingMenuOptions {
        
        let screenW = UIScreen.mainScreen().bounds.size.width
        let options = PagingMenuOptions()
        
        options.menuHeight = 48
        options.menuItemMargin = 10
        options.menuItemMode = PagingMenuOptions.MenuItemMode.Underline(height: 3, color: ConstantColor.black(), horizontalPadding: 0, verticalPadding: 0)
        options.font = UIFont.boldSystemFontOfSize(16)
        options.selectedFont = UIFont.boldSystemFontOfSize(16)
        options.textColor = ConstantColor.gray()
        options.selectedTextColor = ConstantColor.black()
        options.menuDisplayMode = .Infinite(widthMode: PagingMenuOptions.MenuItemWidthMode.Fixed(width: screenW / 100 * 30))
        
        return options
        
    }
    
}