import UIKit
import TwitterKit
import WebImage

class UserDetailInfoViewCell: UITableViewCell {
    
    @IBOutlet weak var profileBannerURL: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var urlLabel: UILabel!
    
    @IBOutlet weak var followerView: UIView!
    
    func setup(profileData: ProfileDetailData) {
        let profileImageURL = NSURL(string: profileData.profileImageURL)
        self.profileImageView.sd_setImageWithURL(profileImageURL)
        
        let profileBannerURL = NSURL(string: profileData.profileBannerURL)
        self.profileBannerURL.sd_setImageWithURL(profileBannerURL)
        
        self.nameLabel.text = profileData.name
        self.screenNameLabel.text = "@" + profileData.screenName
        self.descriptionLabel.text = profileData.description
        
        self.locationLabel.text = profileData.location
        
        self.urlLabel.text = profileData.url
        
        if !profileData.following {
            self.followerView.alpha = 0
        }
    }
}
