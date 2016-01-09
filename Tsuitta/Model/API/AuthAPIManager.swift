import TwitterKit

class AuthAPIManager {
    
    private let twitter = Twitter.sharedInstance()
    
    func login(callback: TWTRLogInCompletion) {
        twitter.logInWithCompletion { session, error in
            callback(session, error)
        }
    }
    
    func logout(){
        guard let userID = APILocator.sharedInstance.user.id() else {
            debug("ログインされてないでえ")
            return
        }
        let store = twitter.sessionStore
        store.logOutUserID(userID)
    }
}