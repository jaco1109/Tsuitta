import UIKit
import WebImage

enum ProfileConfigItem: Int {
    case Image = 0
    case Name
    case Description
    case Location
    case Url
    
    func title() -> String {
        switch self {
        case .Image:
            return ""
        case .Name:
            return "名前"
        case .Description:
            return "説明"
        case .Location:
            return "場所"
        case .Url:
            return "Webサイト"
        }
    }
    
    func defaultValue(data: ProfileDetailData) -> String {
        switch self {
        case .Image:
            return ""
        case .Name:
            return data.name
        case .Description:
            return data.description
        case .Location:
            return data.location
        case Url:
            return data.url
        }
    }
    
    static func count() -> Int {
        return 5
    }
}

class ProfileConfigView: UIView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    private let cellIdentifier = "Cell"
    
    private var profileData: ProfileDetailData?
    
    @IBOutlet weak private var tableView: UITableView! {
        didSet{
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            self.tableView.estimatedRowHeight = 200
            self.tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    @IBAction func didTapScreen(sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    func setup(data : ProfileDetailData) {
        self.profileData = data
        self.tableView.reloadData()
    }
    
    //MARK: CreateCell
    
    private func createProfileImageConfigCell(iconImageURL: NSURL, bannerImageURL: NSURL) -> ProfileImageConfigTableViewCell {
        guard let cell = UINib(nibName: "ProfileImageConfigTableViewCell", bundle: nil).instantiateWithOwner(self, options: nil).first as? ProfileImageConfigTableViewCell else{
            return ProfileImageConfigTableViewCell()
        }
        
        cell.iconImageView.sd_setImageWithURL(iconImageURL)
        cell.bannerImageView.sd_setImageWithURL(bannerImageURL)
        
        return cell
    }
    
    private func createProfileTextConfigCell(title: String, defaultVal: String) -> ProfileTextConfigTableViewCell {
        guard let cell = UINib(nibName: "ProfileTextConfigTableViewCell", bundle: nil).instantiateWithOwner(self, options: nil).first as? ProfileTextConfigTableViewCell else{
            return ProfileTextConfigTableViewCell()
        }
        
        cell.titleLabel.text = title
        cell.textField.text = defaultVal
        cell.textField.delegate = self
        
        return cell
    }
    
    private func createProfileDescriptionConfigCell(defaultVal: String) -> ProfileDescriptionConfigTableViewCell {
        guard let cell = UINib(nibName: "ProfileDescriptionConfigTableViewCell", bundle: nil).instantiateWithOwner(self, options: nil).first as? ProfileDescriptionConfigTableViewCell else{
            return ProfileDescriptionConfigTableViewCell()
        }
        
        cell.textView.text = defaultVal
        
        return cell
    }
    
    //MARK: TableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileConfigItem.count()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let data = self.profileData else{
            return UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        
        let type = ProfileConfigItem.init(rawValue: indexPath.row)!
        
        var cell: UITableViewCell
        switch type {
        case .Image:
            cell = self.createProfileImageConfigCell(NSURL(string: data.profileImageURL)!, bannerImageURL: NSURL(string: data.profileBannerURL)!)
        case .Description:
            cell = self.createProfileDescriptionConfigCell(type.defaultValue(data))
        default:
            cell = self.createProfileTextConfigCell(type.title(), defaultVal: type.defaultValue(data))
        }

        return cell
    }
    
    //MARK: TextField
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}