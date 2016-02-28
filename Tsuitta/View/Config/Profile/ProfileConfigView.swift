import UIKit

class ProfileConfigView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private let cellIdentifier = "Cell"
    
    @IBOutlet weak private var tableView: UITableView! {
        didSet{
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            self.tableView.estimatedRowHeight = 200
            self.tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    //MARK: CreateCell
    
    private func createProfileImageSettingCell(icon: UIImage, banner: UIImage) -> ProfileImageConfigTableViewCell {
        let cell = ProfileImageConfigTableViewCell()
        
        cell.iconImageView.image = icon
        cell.iconImageView.image = banner
        
        return cell
    }
    
    //MARK: TableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        cell.textLabel?.text =
        
    }
}