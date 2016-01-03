//
//  APIManager.swift
//  Tsuitta
//
//  Created by domon on 2015/12/13.
//  Copyright © 2015年 土門良輔. All rights reserved.
//

import TwitterKit
import SwiftyJSON

enum APIStatus{
    case Success
    case Error
}

class GetAPIManager {
    
    //MARK: property
    
    static let sharedInstance = GetAPIManager()
    
    private let twitter = Twitter.sharedInstance()
    
    private let client = TWTRAPIClient()
    
    private let api = APIClient()
    
    //MARK: init
    
    private init(){
        
    }
    
    //MARK: UserID
    
    private func userID() -> String? {
        if let userID = twitter.sessionStore.session()?.userID {
            return userID
        }
        return nil
    }
    
    //MARK: Login
    
    func login(callback: TWTRLogInCompletion) {
        twitter.logInWithCompletion { session, error in
            callback(session, error)
        }
    }
    
    func logout(){
        guard let userID = userID() else {
            debug("ログインされてないでえ")
            return
        }
        let store = twitter.sessionStore
        store.logOutUserID(userID)
    }
    
}
