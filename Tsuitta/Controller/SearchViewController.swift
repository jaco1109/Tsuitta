import UIKit
import TwitterKit

class SearchViewController: UIViewController, SearchHeaderTableViewCellDelegate {
    
    override func loadView() {
        super.loadView()
        
        if let view = UINib(nibName: "SearchView", bundle: nil).instantiateWithOwner(self, options: nil).first as? SearchView {
            view.delegate = self
            self.view = view
        }
    }
    
    //MARK: SearchHeaderTableViewCellDelegate
    
    func requestSearchTweet(word: String, callback: ([TWTRTweet]) -> Void) {
        APILocator.sharedInstance.search.tweets(word, callback: callback)
    }
    
    func requestSearchUser(word: String, callback: ([TWTRUser]) -> Void) {
        APILocator.sharedInstance.search.users(word, callback: callback)
    }
    
    func requestSearchImage(word: String, callback: ([TWTRTweet]) -> Void) {
        APILocator.sharedInstance.search.images(word, callback: callback)
    }
    
}