//
//  TweetTableViewCell.swift
//  Tsuitta
//
//  Created by jaco on 2015/12/13.
//  Copyright © 2015年 土門良輔. All rights reserved.
//

import UIKit
import TwitterKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var created: UILabel!
    var tweet: TWTRTweet! {
        didSet {
            self.userImage?.sd_setImageWithURL(NSURL(string: tweet.author.profileImageLargeURL))
        }
    }
    
    func configure(tweet: TWTRTweet) {
        
        self.userId.text = tweet.author.name
        self.userName.text = "@" + tweet.author.screenName
        self.created.text = self.convertDateToString(tweet.createdAt)
        self.tweetText.text = tweet.text
        self.tweet = tweet
        
    }
    
    // MARK: NSDate型の日付を文字列型に変換する
    // TODO: 「◯◯前」みたいに経過時間を返すようにする
    private func convertDateToString(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let dateString: String = dateFormatter.stringFromDate(date)
        
        return dateString
    }
    
}