import UIKit

class ProfileConfigViewController: UIViewController {
    override func loadView() {
        super.loadView()
        
        if let view = UINib(nibName: "ProfileConfigView", bundle: nil).instantiateWithOwner(self, options: nil).first as? ProfileConfigView {
            self.view = view
        }
    }
}