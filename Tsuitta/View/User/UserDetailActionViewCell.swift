import UIKit

class UserDetailActionViewCell: UITableViewCell {

    @IBOutlet weak var followCountLabel: UILabel!
    
    @IBOutlet weak var followerCountLabel: UILabel!
    
    @IBOutlet weak var tweetCountLabel: UILabel!
    
    
    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBAction func didTapActionButton(sender: UIButton) {
        //TODO: 実装してね！
    }
    
    
    @IBAction func didTapFollowButton(sender: UIButton) {
        //TODO: 実装してね！
    }
    
    func setup(profileData: ProfileDetailData) {
        self.followCountLabel.text = String(profileData.friendsCount)
        self.followerCountLabel.text = String(profileData.followersCount)
        self.tweetCountLabel.text = String(profileData.statusesCount)
        self.likeCountLabel.text = String(profileData.favouritesCount)
    }
}
