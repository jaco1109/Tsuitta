import UIKit
import TwitterKit

class TweetDetailViewController: UIViewController {
    
    private var tweet: TWTRTweet!
    
    override func loadView() {
        super.loadView()
        
        if let view = UINib(nibName: "TweetDetailView", bundle: nil).instantiateWithOwner(self, options: nil).first as? TweetDetailView {
            self.view = view
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APILocator.sharedInstance.tweet.single("678556859976933376", callback: { (tweet) -> Void in
            guard let v = self.view as? TweetDetailView else {
                return
            }
            v.reloadMainTweetData(tweet)
            self.tweet = tweet
        })
    }
}