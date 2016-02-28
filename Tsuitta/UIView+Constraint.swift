import UIKit

extension UIView {
    /**
     addSubViewした後に、Viewを親Viewと同じ大きさになるようにConstraintを設定する。
     
     - parameter view: addSubViewするView
     */
    //TODO: メソッド名ひどいので修正したい
    func addSubviewWithFullConstraint(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(view)
        
        self.addConstraints(
            [
                createConstraint(view, attr: .Top),
                createConstraint(view, attr: .Right),
                createConstraint(view, attr: .Bottom),
                createConstraint(view, attr: .Left)
            ]
        )
    }
    
    /**
     引数のViewとselfのattrをequal指定にしたconstraintを作成します。
     TODO:↑ちょっと何言ってるかわからないね
     
     - parameter view: constraintを追加するView
     - parameter attr: constraintを設定するattr
     
     - returns: constraint
     */
    // TODO: メソッド名修正したい
    private func createConstraint(view: UIView, attr: NSLayoutAttribute) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: self,
            attribute: attr,
            relatedBy: .Equal,
            toItem: view,
            attribute: attr,
            multiplier: 1.0,
            constant: 0
        )
    }
}