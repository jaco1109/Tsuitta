import UIKit
import TwitterKit

class TimeLineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView!
    var tweets: [TWTRTweet] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var prototypeCell: TWTRTweetTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        
        prototypeCell = TWTRTweetTableViewCell(style: .Default, reuseIdentifier: "cell")
        
        tableView.registerClass(TWTRTweetTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        loadTweets()
        
        self.navigationController?.navigationBarHidden = false
        
        settingTest()
    }
    
    func settingTest(){
        APILocator.sharedInstance.setting.account.iconImage()
        var account = Account()
        account.description = "よろしこしこ"
        APILocator.sharedInstance.setting.account.profile(account)
    }
    
    func searchTest(){
        APILocator.sharedInstance.search.users("Twitter API") {
            users in
            users.forEach({ (user) -> () in
                debug("-------------")
                debug(user.userID)
            })
        }
    }
    
    func muteTest(){
        let id = 213587955
        APILocator.sharedInstance.user.mute(id)
        NSThread.sleepForTimeInterval(5)
        APILocator.sharedInstance.user.related(id, targetId: id)
        
        APILocator.sharedInstance.user.undoMute(id)
        NSThread.sleepForTimeInterval(5)
        APILocator.sharedInstance.user.related(id, targetId: id)
    }
    
    func followTest(){
        let id = 213587955
        APILocator.sharedInstance.user.follow(id)
        NSThread.sleepForTimeInterval(5)
        APILocator.sharedInstance.user.related(id, targetId: id)
        
        APILocator.sharedInstance.user.remove(id)
        NSThread.sleepForTimeInterval(5)
        APILocator.sharedInstance.user.related(id, targetId: id)
        
    }
    
    func likeTest(){
        let id = 678556859976933376
        APILocator.sharedInstance.tweet.like(id)
        NSThread.sleepForTimeInterval(5)
        APILocator.sharedInstance.tweet.likeList(){
            tweets in
        }
        APILocator.sharedInstance.tweet.undoLike(id)
        NSThread.sleepForTimeInterval(5)
        APILocator.sharedInstance.tweet.likeList(){
            tweets in
        }
    }
    
    func loadTweets() {
        APILocator.sharedInstance.search.images("d") {
            tweets in
            for tweet in tweets {
                self.tweets.append(tweet)
            }
        }
        APILocator.sharedInstance.tweet.single("678556859976933376", callback: { (tweets) -> Void in
            self.tweets.append(tweets)
        })
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of Tweets.
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! TWTRTweetTableViewCell
        
        let tweet = tweets[indexPath.row]
        cell.configureWithTweet(tweet)
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let tweet = tweets[indexPath.row]
        
        return TWTRTweetTableViewCell.heightForTweet(tweet, width: self.view.bounds.width)
    }
}