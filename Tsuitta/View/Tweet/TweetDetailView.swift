import UIKit
import TwitterKit

/// ツイート詳細画面のView部分
class TweetDetailView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private var mainTweetData: TWTRTweet?
    
    @IBOutlet weak private var tableView: UITableView!{
        didSet{
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            self.tableView.estimatedRowHeight = 200
            self.tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    private func createMainTweetDetailTableViewCell() -> MainTweetDetailTableViewCell? {
        guard let tweet = mainTweetData else{
            return nil
        }
        
        guard let cell = UINib(nibName: "MainTweetDetailTableViewCell", bundle: nil).instantiateWithOwner(self, options: nil).first as? MainTweetDetailTableViewCell else {
            return nil
        }
        
        cell.selectionStyle = .None
        cell.setup(tweet)
        
        
        return cell
    }
    
    func reloadMainTweetData(tweetData: TWTRTweet) {
        self.mainTweetData = tweetData
        
        self.tableView.reloadData()
    }
    
    //MARK: TableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return createMainTweetDetailTableViewCell() ?? UITableViewCell()
    }
}
