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
    
    //MARK: UserData
    
    //TODO: とりあえずここに書いていますが、後でちゃんと書き直します。
    struct TWTRCoreUser{
        private(set) var userID: String
        private(set) var name: String
        private(set) var screenName: String
        private(set) var profileImageURL: String
        
        init(userData: TWTRUser){
            userID = userData.userID
            name = userData.name
            screenName = userData.screenName
            profileImageURL = userData.profileImageURL
        }
    }
    
    //TODO: とりあえず毎回requestを送ってdataを取得します。
    //そのうち、dataクラスを作成して、初回のみrequestを飛ばしてそれ以外はdataクラスから必要なデータのみ取得します。
    func userData(callback: (TWTRCoreUser?, NSError?) -> Void){
        guard let userID = userID() else {
            debug("ログインされてないでえ")
            return
        }
        
        client.loadUserWithID(userID) { (user, error) -> Void in
            if let u = user {
                callback(TWTRCoreUser(userData: u), error)
            } else {
                debug("えらーだお")
            }
        }
    }
    
    //TODO: とりあえず毎回requestを送ってdataを取得します。
    //そのうち、dataクラスを作成して、初回のみrequestを飛ばしてそれ以外はdataクラスから必要なデータのみ取得します。
    func profileData(callback: TWTRLoadUserCompletion){
        guard let userID = userID() else {
            debug("ログインされてないでえ")
            return
        }
        
        client.loadUserWithID(userID) { (user, error) -> Void in
            callback(user, error)
        }
    }
    
}
