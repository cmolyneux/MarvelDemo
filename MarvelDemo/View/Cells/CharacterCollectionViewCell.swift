import UIKit
import AlamofireImage

class CharacterCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var characterNameLabel: UILabel!
  @IBOutlet weak var thumbnailImageview: UIImageView!
    
  func setupView(name: String?, imagePath: String?) {
    characterNameLabel.text = name
    guard let imageUrl = URL(string: imagePath!) else {
      return
    }
    thumbnailImageview.af_setImage(withURL: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeholder"))
  }
}

