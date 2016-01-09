import TwitterKit

/// API系のModelをまとめて管理しています。このクラス経由でAPIを呼び出すようにしてください。
class APILocator {
    static let sharedInstance = APILocator()
    
    let get = GetAPIManager()
    
    let post = PostAPIManager()
    
    private init(){
    
    }
}