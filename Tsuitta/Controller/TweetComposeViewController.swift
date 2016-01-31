import UIKit

/// ツイート投稿画面のVC
class TweetComposeViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        
        if let view = UINib(nibName: "TweetComposeView", bundle: nil).instantiateWithOwner(self, options: nil).first as? TweetComposeView {
            self.view = view
        }
    }
}