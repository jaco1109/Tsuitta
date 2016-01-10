import TwitterKit
import SwiftyJSON

class UserAPIManager {
    
    private let twitter = Twitter.sharedInstance()
    
    private let client = TWTRAPIClient()
    
    //MARK: userData
    
    func id() -> String? {
        if let userID = twitter.sessionStore.session()?.userID {
            return userID
        }
        return nil
    }
    
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
    func coreData(callback: (TWTRCoreUser?, NSError?) -> Void){
        guard let userID = id() else {
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
        guard let userID = id() else {
            debug("ログインされてないでえ")
            return
        }
        
        client.loadUserWithID(userID) { (user, error) -> Void in
            callback(user, error)
        }
    }

}