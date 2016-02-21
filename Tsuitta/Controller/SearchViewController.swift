import UIKit

class SearchViewController: UIViewController {
    override func loadView() {
        super.loadView()
        
        if let view = UINib(nibName: "SearchView", bundle: nil).instantiateWithOwner(self, options: nil).first as? SearchView {
            view.delegate = self
            self.view = view
        }
    }
    
}