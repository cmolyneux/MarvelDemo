import UIKit
import Alamofire
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

    //Example Alamofire request
//    Alamofire.request(imageUrl, method: .get).responseImage { response in
//      guard let image = response.result.value else {
//        print("error download image")
//        return
//      }
//      self.thumbnailImageview.image = image
//    }
  }
}

