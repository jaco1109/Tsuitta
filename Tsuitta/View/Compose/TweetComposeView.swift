import UIKit

class TweetComposeView: UIView {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak private var placeholderLabel: UILabel!
    
    @IBOutlet weak private var textCountLabel: UILabel!
    
    private let actionViewHeight: CGFloat = 60
    
    private let tweetMaxTextLength = 140
    
    //MARK: Init
    
    // コードから呼ばれたら　こっちは使わないでね
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // IBから呼ばれたら こっち使ってね
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let notification = NSNotificationCenter.defaultCenter()
        notification.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        
        notification.addObserver(self, selector:"textFieldDidChange:", name: UITextViewTextDidChangeNotification, object: nil)
    }
    
    deinit{
        let notification = NSNotificationCenter.defaultCenter()
        notification.removeObserver(self)
    }
    
    //MARK: LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //TODO: textViewのサイズを小さくすると(キーボード出現時)textViewがスクロールできる状態になる(中身は何もない)
        //そのため、文字列を入れると再レイアウトがかかり(たぶん)いい感じになる。そのため、下記でなぞの処理を行っている。
        if self.textView.text.isEmpty {
            self.textView.text = " "
            self.textView.text = ""
        }
    }
    
    //MARK: -
    
    @IBAction func didTapCloseButton(sender: UIButton) {
        //TODO: 処理実装するよ
    }
    
    
    @IBAction func didTapCameraButton(sender: UIButton) {
        //TODO: 処理実装するよ
    }
    
    @IBAction func didTapTweetButton(sender: UIButton) {
        //TODO: 処理実装するよ
    }
    
    @objc private func handleKeyboardWillShowNotification(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()// 画面のサイズを取得
        let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
        
        let displayHeight = myBoundSize.height - keyboardRect.size.height
        
        var frame = self.frame
        frame.size.height = displayHeight
        self.frame = frame
    }
    
    @objc private func textFieldDidChange(notification: NSNotification) {
        self.placeholderLabel.hidden = !self.textView.text.isEmpty
        
        self.textCountLabel.text = String(tweetMaxTextLength - self.textView.text.characters.count)
    }
}
