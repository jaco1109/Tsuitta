import UIKit
import TwitterKit

class UserDetailView: UIView, UITableViewDelegate, UITableViewDataSource  {
    
    private var profileData: ProfileDetailData?
    
    @IBOutlet weak private var tableView: UITableView!{
        didSet{
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            self.tableView.estimatedRowHeight = 200
            self.tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    private func createUserDetailInfoViewCell() -> UserDetailInfoViewCell? {
        guard let profileData = self.profileData else {
            return nil
        }
        
        guard let cell = UINib(nibName: "UserDetailInfoViewCell", bundle: nil).instantiateWithOwner(self, options: nil).first as? UserDetailInfoViewCell else {
            return nil
        }
        
        cell.selectionStyle = .None
        cell.setup(profileData)
        
        return cell
    }
    
    private func createUserDetailActionViewCell() -> UserDetailActionViewCell? {
        guard let profileData = self.profileData else {
            return nil
        }
        
        guard let cell = UINib(nibName: "UserDetailActionViewCell", bundle: nil).instantiateWithOwner(self, options: nil).first as? UserDetailActionViewCell else {
            return nil
        }
        
        cell.selectionStyle = .None
        cell.setup(profileData)
        
        return cell
    }
    
    func reloadProfileData(profileData: ProfileDetailData) {
        self.profileData = profileData
        
        self.tableView.reloadData()
    }
    
    //MARK: TableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return createUserDetailInfoViewCell() ?? UITableViewCell()
        }
        
        return createUserDetailActionViewCell() ?? UITableViewCell()
    }
}
