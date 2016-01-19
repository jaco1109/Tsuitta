import TwitterKit

/// API系のModelをまとめて管理しています。このクラス経由でAPIを呼び出すようにしてください。
class APILocator {
    static let sharedInstance = APILocator()
    
    let auth = AuthAPIManager()
    
    let tweet = TweetAPIManager()
    
    let user = UserAPIManager()
    
    let search = SearchAPIManager()
    
    let setting = SettingAPIManager()
    
    private init(){
    
    }
}