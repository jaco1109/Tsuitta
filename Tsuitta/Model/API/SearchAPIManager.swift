import TwitterKit
import SwiftyJSON

class SearchAPIManager {
    
    private let twitter = Twitter.sharedInstance()
    
    func users(searchWord: String, callback: ([TWTRUser]) -> Void){
        APIClient.get("/users/search.json", parameter: ["q": searchWord, "count": "25"]) { (response, data, error) -> Void in
            if let err = error {
                print("エラーだよ：\(err.code)")
                return
            }
            if let d = data {
                let json2 = JSON(data: d)
                let jsonArray = json2.arrayObject
                let users = TWTRUser.usersWithJSONArray(jsonArray) as! [TWTRUser]
                callback(users)
            }
        }
    }
    
    func tweets(searchWord: String, callback: ([TWTRTweet]) -> Void){
        APIClient.get("/search/tweets.json", parameter: ["q": "#" + searchWord, "count": "25"]) { (response, data, error) -> Void in
            if let err = error {
                print("エラーだよ：\(err.code)")
                return
            }
            if let d = data {
                let json2 = JSON(data: d)
                let jsonArray = json2["statuses"].arrayObject
                let tweets = TWTRTweet.tweetsWithJSONArray(jsonArray) as! [TWTRTweet]
                callback(tweets)
            }
        }
    }
    
    func images(searchWord: String, callback: ([TWTRTweet]) -> Void){
        APIClient.get("/search/tweets.json", parameter: ["q": "#" + searchWord + " filter:images", "count": "25", "include_entities": "true"]) { (response, data, error) -> Void in
            if let err = error {
                print("エラーだよ：\(err.code)")
                return
            }
            if let d = data {
                let json2 = JSON(data: d)
                let jsonArray = json2["statuses"].arrayObject
                let tweets = TWTRTweet.tweetsWithJSONArray(jsonArray) as! [TWTRTweet]
                callback(tweets)
            }
        }
    }
}