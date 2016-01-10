import TwitterKit
import SwiftyJSON

class TweetAPIManager {
    
    private let client = TWTRAPIClient()
    
    //MARK: Get Tweet
    
    func single(tweetID: String, callback: (TWTRTweet) -> Void){
        client.loadTweetWithID(tweetID) { tweet, error in
            if let t = tweet {
                callback(t)
            } else {
                debug("Failed to load Tweet: \(error?.localizedDescription)")
            }
        }
    }
    
    //TODO: テスト用に自分自身のTLを引っ張ってきます。
    func homeTimeLine(callback: ([TWTRTweet]) -> Void){
        //TODO: とりあえず最新の20件をもってきます。
        //それ以外のデータに関しては今後取れるように修正します。
        APIClient.get("/statuses/home_timeline.json", parameter: ["count": "20"]) { (response, data, error) -> Void in
            if let err = error {
                debug("エラーだよ：\(err.code)")
                return
            }
            var json: AnyObject?
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
            } catch {
                return
            }
            if let jsonArray = json as? [AnyObject] {
                let tweets = TWTRTweet.tweetsWithJSONArray(jsonArray) as! [TWTRTweet]
                callback(tweets)
            }
        }
    }
    
    func timeLine(var userID: String, callback: ([TWTRTweet]) -> Void){
        //TODO: とりあえずテストのために自分のuserIDをセットしてます。修正するよ!
        if let ID = APILocator.sharedInstance.user.id() {
            userID = ID
        }
        APIClient.get("/statuses/user_timeline.json", parameter: ["user_id": userID, "count": "25"]) { (response, data, error) -> Void in
            if let err = error {
                debug("エラーだよ：\(err.code)")
                return
            }
            var json: AnyObject?
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
            } catch {
                return
            }
            if let jsonArray = json as? [AnyObject] {
                let tweets = TWTRTweet.tweetsWithJSONArray(jsonArray) as! [TWTRTweet]
                callback(tweets)
            }
        }
    }
}
