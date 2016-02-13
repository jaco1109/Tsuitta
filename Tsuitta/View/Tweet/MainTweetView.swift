import UIKit
import TwitterKit

/// ツイート詳細画面のメインのツイートの一部。ツイートの内容を表示するView。特にActionはない。
class MainTweetView: UIView {
    
    @IBOutlet weak private var profileImageView: UIImageView!
    
    @IBOutlet weak private var screenNameLabel: UILabel!
    
    @IBOutlet weak private var nameLabel: UILabel!
    
    @IBOutlet weak private var contentLabel: UILabel!
    
    @IBOutlet weak private var contentImageAreaView: UIView!
    
    @IBOutlet weak private var dateLabel: UILabel!
    
    @IBOutlet weak private var retweetLabel: UILabel!
    
    @IBOutlet weak private var likeLabel: UILabel!
    
    private var tweetId: String!
    
    func setup(tweetData: TWTRTweet) {
        self.tweetId = tweetData.tweetID
        //TODO: deprecated なおそ！
        let req = NSURLRequest(URL:NSURL(string: tweetData.author.profileImageURL)!)
        NSURLConnection.sendAsynchronousRequest(req, queue:NSOperationQueue.mainQueue()){(res, data, err) in
            self.profileImageView.image = UIImage(data:data!)
        }
        
        self.screenNameLabel.text = tweetData.author.screenName
        self.nameLabel.text = tweetData.author.name
        self.contentLabel.text = tweetData.text
        self.dateLabel.text = self.convertNSDateToString(tweetData.createdAt)
        self.retweetLabel.text = String(tweetData.retweetCount) + "RT"
        self.likeLabel.text = String(tweetData.likeCount) + "Like"
    }
    
    
    //TODO: 後で便利関数にまとめる
    private func convertNSDateToString(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "YYYY-MM-dd hh:mm:ss"
        
        return formatter.stringFromDate(date)
    }
}
