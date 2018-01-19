import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var characterNameLabel: UILabel!
  
  func setupView(name: String) {
    characterNameLabel.text = name
  }
}
