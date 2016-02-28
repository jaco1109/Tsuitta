import UIKit

class ConfigViewController: UIViewController {
    override func loadView() {
        super.loadView()
        
        if let view = UINib(nibName: "ConfigView", bundle: nil).instantiateWithOwner(self, options: nil).first as? ConfigView {
            self.view = view
        }
    }
}