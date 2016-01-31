import UIKit
import TwitterKit

class MainTweetDetailTableViewCell: UITableViewCell {
    
    private var mainTweetView: MainTweetView?
    
    @IBOutlet weak private var RetweetView: UIView!
    
    @IBOutlet weak private var RetweetLabel: UILabel!
    
    @IBOutlet weak private var tweetView: UIView!{
        didSet{
            if let view = UINib(nibName: "MainTweetView", bundle: nil).instantiateWithOwner(self, options: nil).first as? MainTweetView {
                self.mainTweetView = view
                self.tweetView.addSubviewWithFullConstraint(view)
            }
        }
    }
    
    @IBAction func didTapReplyButton(sender: UIButton) {
        //TODO: Reply を実装するよ
    }
    
    @IBAction func didTapRetweetButton(sender: UIButton) {
        //TODO: Retweet を実装するよ
    }
    
    @IBAction func didTapLikeButton(sender: UIButton) {
        //TODO: Like を実装するよ
    }
    
    @IBAction func didTapActionButton(sender: UIButton) {
        //TODO: その他のアクションを実装するよ
    }
    
    func setup(tweetData: TWTRTweet) {
        guard let v = self.mainTweetView else {
            return
        }
        v.setup(tweetData)
    }
    
    private func setupRetweet() {
        //TODO: Retweet していたらRetweetのやつ表示する
    }
    
    
}
