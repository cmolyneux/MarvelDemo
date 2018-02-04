import UIKit

extension UICollectionViewCell {
  class var identifier: String {
    return String(describing: self)
  }
  
  class var nib: UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
}
