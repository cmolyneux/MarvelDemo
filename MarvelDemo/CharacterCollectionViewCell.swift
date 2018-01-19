import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var characterNameLabel: UILabel!
  @IBOutlet weak var thumbnailImageview: UIImageView!
  
  func setupView(name: String, imagePath: String) {
    characterNameLabel.text = name
    thumbnailImageview.downloadedFrom(url: imagePath)
  }
}
