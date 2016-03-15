import UIKit

class CameraRollCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var selectedView: UIView!
    
    var didSelected = false {
        didSet{
            if self.didSelected {
                self.selectedView.alpha = 1
            } else {
                self.selectedView.alpha = 0
            }
        }
    }
}
