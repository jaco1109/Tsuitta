import UIKit

protocol CameraRollViewControllerDelegate {
    func addImage(photos: [UIImage], indexPaths: [NSIndexPath])
}

class CameraRollViewController: UIViewController {
    
    var selectedPhotoIndexPaths: [NSIndexPath]?
    
    var delegate: CameraRollViewControllerDelegate?
    
    override func loadView() {
        super.loadView()
        
        if let view = UINib(nibName: "CameraRollView", bundle: nil).instantiateWithOwner(self, options: nil).first as? CameraRollView {
            self.view = view
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cameraRollView = self.view as! CameraRollView
        cameraRollView.loadCollectionViewData(selectedPhotoIndexPaths)
        
        self.navigationController?.navigationBar.translucent = false
        
        let rightButton = UIBarButtonItem(title: "キャンセル", style: .Plain, target: self, action: "closeViewController")
        let leftButton = UIBarButtonItem(title: "追加する", style: .Plain, target: self, action: "addImage")
        
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc private func closeViewController() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func addImage() {
        let cameraRollView = self.view as! CameraRollView
        if let photos = cameraRollView.getSelectedPhoto(), indexPaths = cameraRollView.getSelectedPhotoIndexPaths() {
            self.delegate?.addImage(photos, indexPaths: indexPaths)
        }
        self.closeViewController()
    }
    
    
    
}