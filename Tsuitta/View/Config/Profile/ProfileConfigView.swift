import UIKit
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

class ProfileConfigView: UIView, UITableViewDelegate, UITableViewDataSource {
    
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
    
    func setup(data : ProfileDetailData) {
        self.profileData = data
        self.tableView.reloadData()
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