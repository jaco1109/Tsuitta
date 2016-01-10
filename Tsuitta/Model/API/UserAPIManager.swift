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
    
    //MARK: Follow
    
    func follow(userId: Int){
        let id = String(userId)
        APIClient.post("/friendships/create.json", parameter: ["user_id": id, "follow": "true"]) { (response, data, error) -> Void in
            if let err = error {
                debug("エラーだよ：\(err.code)")
                return
            }
            
        }
    }
    
    func remove(userId: Int){
        let id = String(userId)
        APIClient.post("/friendships/destroy.json", parameter: ["user_id": id]) { (response, data, error) -> Void in
            if let err = error {
                debug("エラーだよ：\(err.code)")
                return
            }
        }
    }
    
    func followList(callback: ([TWTRCoreUser]) -> Void){
        APIClient.post("/friends/list.json", parameter: ["user_id": id()!]) { (response, data, error) -> Void in
            if let err = error {
                debug("エラーだよ：\(err.code)")
                return
            }
            let json = JSON(data: data!).arrayObject
            if let jsonArray = json {
                let usersData = TWTRUser.usersWithJSONArray(jsonArray) as! [TWTRUser]
                let coreUsersData = usersData.map{TWTRCoreUser(userData: $0)}
                
                callback(coreUsersData)
            }
        }
    }
    
    func followerList(callback: ([TWTRCoreUser]) -> Void){
        //TODO: とりあえず自分のを取得するようにしてます
        APIClient.post("/followers/list.json", parameter: ["user_id": id()!]) { (response, data, error) -> Void in
            if let err = error {
                debug("エラーだよ：\(err.code)")
                return
            }
            let json = JSON(data: data!).arrayObject
            if let jsonArray = json {
                let usersData = TWTRUser.usersWithJSONArray(jsonArray) as! [TWTRUser]
                let coreUsersData = usersData.map{TWTRCoreUser(userData: $0)}
                
                callback(coreUsersData)
            }
        }
    }
    
    //MARK: Mute
    
    func mute(userId: Int){
        let id = String(userId)
        APIClient.post("/mutes/users/create.json", parameter: ["user_id": id]) { (response, data, error) -> Void in
            if let err = error {
                debug("エラーだよ：\(err.debugDescription)")
                return
            }
        }
    }
    
    func undoMute(userId: Int){
        let id = String(userId)
        APIClient.post("/mutes/users/destroy.json", parameter: ["user_id": id]) { (response, data, error) -> Void in
            if let err = error {
                debug("エラーだよ：\(err.debugDescription)")
                return
            }
        }
    }
    
    func muteList(callback: ([TWTRCoreUser]) -> Void){
        APIClient.get("/mutes/users/list.json") { (response, data, error) -> Void in
            if let err = error {
                debug("エラーだよ：\(err.debugDescription)")
                return
            }
            let json = JSON(data: data!).arrayObject
            if let jsonArray = json {
                let usersData = TWTRUser.usersWithJSONArray(jsonArray) as! [TWTRUser]
                let coreUsersData = usersData.map{TWTRCoreUser(userData: $0)}
                
                callback(coreUsersData)
            }
        }
    }
    
    //MARK: Block
    
    func block(blockId: Int){
        let id = String(blockId)
        APIClient.post("/blocks/create.json", parameter: ["user_id": id]) { (response, data, error) -> Void in
            if let err = error {
                debug("エラーだよ：\(err.debugDescription)")
                return
            }
        }
    }
    
    func undoBlock(blockId: Int){
        let id = String(blockId)
        APIClient.post("/blocks/create.json", parameter: ["user_id": id]) { (response, data, error) -> Void in
            if let err = error {
                debug("エラーだよ：\(err.debugDescription)")
                return
            }
        }
    }
    
    func blockList(callback: ([TWTRCoreUser]) -> Void){
        APIClient.get("/mutes/users/list.json") { (response, data, error) -> Void in
            if let err = error {
                debug("エラーだよ：\(err.debugDescription)")
                return
            }
            let json = JSON(data: data!).arrayObject
            if let jsonArray = json {
                let usersData = TWTRUser.usersWithJSONArray(jsonArray) as! [TWTRUser]
                let coreUsersData = usersData.map{TWTRCoreUser(userData: $0)}
                
                callback(coreUsersData)
            }
        }
    }
    

}