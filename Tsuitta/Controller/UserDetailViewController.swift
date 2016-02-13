import UIKit

class UserDetailViewController: UIViewController {
    
    
    override func loadView() {
        super.loadView()
        
        if let view = UINib(nibName: "UserDetailView", bundle: nil).instantiateWithOwner(self, options: nil).first as? UserDetailView {
            self.view = view
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APILocator.sharedInstance.user.profileDetailData(Int(APILocator.sharedInstance.user.id()!)!) { (profileDetailData) -> Void in
            guard let v = self.view as? UserDetailView else {
                return
            }
            v.reloadProfileData(profileDetailData)
        }
    }
}
