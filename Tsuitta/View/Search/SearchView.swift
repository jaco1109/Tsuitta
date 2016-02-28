import UIKit
import TwitterKit

class SearchView: UIView, UITableViewDelegate, UITableViewDataSource, SearchHeaderTableViewCellDelegate {
    
    var delegate: SearchHeaderTableViewCellDelegate?
    
    @IBOutlet weak private var tableView: UITableView! {
        didSet{
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            self.tableView.estimatedRowHeight = 200
            self.tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    @IBAction func didTapGesture(sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    private func createSearchHeaderCell() -> SearchHeaderTableViewCell? {
        guard let cell = UINib(nibName: "SearchHeaderTableViewCell", bundle: nil).instantiateWithOwner(self, options: nil).first as? SearchHeaderTableViewCell else {
            return nil
        }
        
        cell.delegate = self
        cell.selectionStyle = .None
        
        return cell
    }
    
    private func createNothingSearchResultCell() -> NothingSearchResultTableViewCell? {
        guard let cell = UINib(nibName: "NothingSearchResultTableViewCell", bundle: nil).instantiateWithOwner(self, options: nil).first as? NothingSearchResultTableViewCell else {
            return nil
        }
        
        cell.selectionStyle = .None
        
        return cell
    }
    
    //MARK: TableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            return self.createSearchHeaderCell() ?? UITableViewCell()
        }
        
        return self.createNothingSearchResultCell() ?? UITableViewCell()
    }
    
    //MARK: SearchHeaderTableViewCellDelegate
    
    func requestSearchTweet(word: String, callback: ([TWTRTweet]) -> Void) {
        self.delegate?.requestSearchTweet(word, callback: callback)
    }
    
    func requestSearchUser(word: String, callback: ([TWTRUser]) -> Void) {
        self.delegate?.requestSearchUser(word, callback: callback)
    }
    
    func requestSearchImage(word: String, callback: ([TWTRTweet]) -> Void) {
        self.delegate?.requestSearchImage(word, callback: callback)
    }
    
    //TODO: セルの実装が終わっていないのでセルの実装が終わり次第セルの更新処理を作成します。
    func reloadtableViewData(type: SelectButtonType, data: [AnyObject]) {
        switch type {
        case .Tweet:
            //TODO: テスト用コードなので、ちゃんと実装しなおすお
            data.forEach { (tweet) -> () in
                guard let t = tweet as? TWTRTweet else{
                    return
                }
                debug("-----------------------")
                debug(t.text)
                debug("-----------------------")
            }
        case .User:
            //TODO: テスト用コードなので、ちゃんと実装しなおすお
            data.forEach { (tweet) -> () in
                guard let t = tweet as? TWTRUser else{
                    return
                }
                
                debug("-----------------------")
                debug(t.name)
                debug("-----------------------")
            }
        case .Image:
            //TODO: テスト用コードなので、ちゃんと実装しなおすお
            data.forEach { (tweet) -> () in
                guard let t = tweet as? TWTRTweet else{
                    return
                }
                
                debug("-----------------------")
                debug(t.text)
                debug("-----------------------")
            }
        }
        
        self.tableView.reloadData()
    }
}