import UIKit
import TwitterKit

/**
 選択している検索のタイプ
 
 - Tweet: ツイート
 - User:  ユーザー
 - Image: 画像
 */
@objc enum SelectButtonType: Int {
    case Tweet
    case User
    case Image
}

/**
 *  検索画面の検索部分のプロトコル
 */
@objc protocol SearchHeaderTableViewCellDelegate: class {
    /**
     ツイート検索のリクエストを飛ばします。
     引数のワードで検索した結果を返してね！
     
     - parameter word: 検索するワード
     - parameter callback: 検索結果を引数に取るコールバック関数
     */
    func requestSearchTweet(word: String, callback: ([TWTRTweet]) -> Void)
    
    /**
     ユーザー検索のリクエストを飛ばします。
     引数のワードで検索した結果を返してね！
     
     - parameter word: 検索するワード
     - parameter callback: 検索結果を引数に取るコールバック関数
     */
    func requestSearchUser(word: String, callback: ([TWTRUser]) -> Void)
    
    /**
     画像ツイート検索のリクエストを飛ばします。
     引数のワードで検索した結果を返してね！
     
     - parameter word: 検索するワード
     - parameter callback: 検索結果を引数に取るコールバック関数
     */
    func requestSearchImage(word: String, callback: ([TWTRTweet]) -> Void)
    
    /**
     テーブルビューをdataとtypeに合わせて更新します
     
     - note: optionalだよ。tableViewの要素がある場合は更新実装してね！
     
     - parameter type: dataのtype
     - parameter data: 表示するデータ
     */
    optional func reloadtableViewData(type: SelectButtonType, data: [AnyObject])
}

/// 検索画面の検索部分のセル
class SearchHeaderTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var delegate: SearchHeaderTableViewCellDelegate?
    
    private var selectedButtonType = SelectButtonType.Tweet
    
    @IBOutlet weak private var searchTextField: UITextField! {
        didSet{
            self.searchTextField.delegate = self
        }
    }
    
    @IBOutlet weak private var tweetButton: UIButton!
    
    @IBOutlet weak private var userButton: UIButton!
    
    @IBOutlet weak private var imageButton: UIButton!
    
    @IBAction func didTapTweetButton(sender: UIButton) {
        self.didTapChangeButtonColor(sender)
        self.selectedButtonType = .Tweet
        
        //TODO: 実装してね
    }
    
    @IBAction func didTapUserButton(sender: UIButton) {
        self.didTapChangeButtonColor(sender)
        self.selectedButtonType = .User
        
        //TODO: 実装してね
    }
    
    @IBAction func didTapImageButton(sender: UIButton) {
        self.didTapChangeButtonColor(sender)
        self.selectedButtonType = .Image
        
        //TODO: 実装してね
    }
    
    /**
     タップしたボタンに合わせて3つのボタンの色を変更します
     
     - parameter tapedButton: タップしたボタン
     */
    private func didTapChangeButtonColor(tapedButton: UIButton) {
        self.changeButtonColor(self.tweetButton, isSelected: false)
        self.changeButtonColor(self.userButton, isSelected: false)
        self.changeButtonColor(self.imageButton, isSelected: false)
        
        self.changeButtonColor(tapedButton, isSelected: true)
    }
    
    /**
     引数のボタンのテキスト色とバックグラウンドの色を選択されたボタンか選択されていないボタン化によって変更します
     
     - parameter button:     UIButton
     - parameter isSelected: 選択されたボタンか選択されていないボタンか
     */
    private func changeButtonColor(button: UIButton, isSelected: Bool) {
        let backgroundColor: UIColor
        let textColor: UIColor
        if isSelected {
            backgroundColor = UIColor.blackColor()
            textColor = UIColor.whiteColor()
        } else {
            backgroundColor = UIColor.whiteColor()
            textColor = UIColor.blackColor()
        }
        
        button.backgroundColor = backgroundColor
        button.setTitleColor(textColor, forState: .Normal)
    }
    
    //MARK: TextField
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        if let searchWord = textField.text {
            self.requestSearchWord(self.selectedButtonType, word: searchWord)
        }
        
        textField.resignFirstResponder()
        
        return true
    }
    
    //MARK: request
    
    private func requestSearchWord(type: SelectButtonType, word: String) {
        switch type {
        case .Tweet:
            self.requestSearchTweet(type, word: word)
        case .User:
            self.requestSearchUser(type, word: word)
        case .Image:
            self.requestSearchImage(type, word: word)
        }
    }
    
    private func requestSearchTweet(type: SelectButtonType, word: String) {
        self.delegate?.requestSearchTweet(word, callback: { (tweets) -> Void in
            self.delegate?.reloadtableViewData?(type, data: tweets)
        })
    }
    
    private func requestSearchUser(type: SelectButtonType, word: String) {
        self.delegate?.requestSearchUser(word, callback: { (users) -> Void in
            self.delegate?.reloadtableViewData?(type, data: users)
        })
    }
    
    private func requestSearchImage(type: SelectButtonType, word: String) {
        self.delegate?.requestSearchImage(word, callback: { (tweets) -> Void in
            self.delegate?.reloadtableViewData?(type, data: tweets)
        })
    }
}