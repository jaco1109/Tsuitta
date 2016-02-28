import UIKit

class ProfileConfigViewController: UIViewController {
    override func loadView() {
        super.loadView()
        
        if let view = UINib(nibName: "ProfileConfigView", bundle: nil).instantiateWithOwner(self, options: nil).first as? ProfileConfigView {
            self.view = view
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let stringID = APILocator.sharedInstance.user.id(), id = Int(stringID) else{
            return
        }
        
        APILocator.sharedInstance.user.profileDetailData(id) { data in
            guard let view = self.view as? ProfileConfigView else{
                return
            }
            
            view.setup(data)
        }
    }
}