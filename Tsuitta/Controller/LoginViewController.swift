//
//  ViewController.swift
//  Tsuitta
//
//  Created by 土門良輔 on 2015/11/21.
//  Copyright © 2015年 土門良輔. All rights reserved.
//

import UIKit
import TwitterKit

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
        Twitter.sharedInstance().logInWithCompletion { session, error in
            if let s = session {
                print("signed in as \(s.userName)");
                s.userID
                self.printAllLoginUserID()
                self.navigationController?.pushViewController(TimeLineViewController(), animated: true)
            } else {
                print("error: \(error?.localizedDescription)")
            }
        }
    }
    
    func didTapLogoutButton() {
        let store = Twitter.sharedInstance().sessionStore
        let sessions = store.existingUserSessions()
        
        if sessions.isEmpty {
            return
        }
        
        if sessions.count == 1 {
            return logout(sessions.first!.userID)
        }
        
        let alert = UIAlertController(title: "ログアウトするアカウントを選択してください", message: nil, preferredStyle: .ActionSheet)
        for session in sessions {
            alert.addAction(UIAlertAction(title: session.userName, style: .Default, handler: { (_) -> Void in
                self.logout(session.userID)
            }))
        }
        alert.addAction(UIAlertAction(title: "キャンセル", style: .Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
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
        print("signed in all userIDs:")
        loginSessions.forEach { (session) -> () in
            print(session.userID)
        }
        print("---------")
    }
}

