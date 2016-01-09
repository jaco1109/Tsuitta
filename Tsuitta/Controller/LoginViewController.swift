//
//  ViewController.swift
//  Tsuitta
//
//  Created by 土門良輔 on 2015/11/21.
//  Copyright © 2015年 土門良輔. All rights reserved.
//

import UIKit
import TwitterKit
import PagingMenuController

class LoginViewController: UIViewController, LoginViewDelegate {
    
    override func loadView() {
        super.loadView()
        
        if let view = UINib(nibName: "LoginView", bundle: nil).instantiateWithOwner(self, options: nil).first as? LoginView {
            self.view = view
            view.delegate = self
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: LoginViewDelegate
    
    func didTapTsuittaLoginButton() {

                let storyBoard = UIStoryboard(name: "TabBar", bundle: nil)
                let vc = storyBoard.instantiateInitialViewController()! as UIViewController
                
                self.navigationController?.pushViewController(vc, animated: true)
        
            } else {
                debug("error: \(error?.localizedDescription)")
            }
        }
        
    }
    
    func didTapLogoutButton() {
        GetAPIManager.sharedInstance.logout()
    }
    
    /**
     引数のIDのアカウントをログアウトします。
     
     - parameter userID: ログアウトするUserID
     */
    private func logout(userID: String){
        let store = Twitter.sharedInstance().sessionStore
        store.logOutUserID(userID)
        printAllLoginUserID()
    }
    
    /**
     ログイン中のuserIDをすべてprintします。
     */
    private func printAllLoginUserID(){
        let loginSessions = Twitter.sharedInstance().sessionStore.existingUserSessions()
        debug("signed in all userIDs:")
        loginSessions.forEach { (session) -> () in
            debug(session.userID)
        }
        debug("---------")
    }
}

