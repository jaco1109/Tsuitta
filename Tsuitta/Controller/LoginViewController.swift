//
//  ViewController.swift
//  Tsuitta
//
//  Created by 土門良輔 on 2015/11/21.
//  Copyright © 2015年 土門良輔. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = TWTRLogInButton(logInCompletion: {
            session, error in
            if let s = session {
                print(s.userName)
                // ログイン成功したらクソ遷移する
                let timelineVC = TimeLineViewController()
                UIApplication.sharedApplication().keyWindow?.rootViewController = timelineVC
            } else {
                print(error!.localizedDescription)
            }
        })
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

