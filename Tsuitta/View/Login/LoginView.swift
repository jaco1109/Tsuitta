//
//  LoginView.swift
//  Tsuitta
//
//  Created by domon on 2015/12/05.
//  Copyright © 2015年 土門良輔. All rights reserved.
//

import UIKit
import TwitterKit

protocol LoginViewDelegate : class{
    /**
     ログインボタンがタップされた時に呼ばれます
     */
    func didTapTsuittaLoginButton()
    /**
     ログアウトボタンがタップされた時に呼ばれます
     */
    func didTapLogoutButton()
}

class LoginView : UIView {
    
    weak var delegate: LoginViewDelegate?
    
    @IBAction func didTapTsuittaLoginButton(sender: UIButton) {
        delegate?.didTapTsuittaLoginButton()
    }
    
    @IBAction func didTapLogoutButton(sender: UIButton) {
        delegate?.didTapLogoutButton()
    }
}
