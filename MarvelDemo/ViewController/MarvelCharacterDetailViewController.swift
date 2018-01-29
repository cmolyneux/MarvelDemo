import UIKit

class MarvelCharacterDetailViewController: UIViewController {
  @IBOutlet weak var headerImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var summaryLabel: UILabel!
  
  private let character: Character
  
  init(character: Character) {
    self.character = character
    super.init(nibName: "MarvelCharacterDetailView", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  func setupView() {
    nameLabel.text = (character.name == "") ? "Classified: No name given" : character.name
    summaryLabel.text = (character.description == "") ? "Classified: No description given" : character.description
    summaryLabel.sizeToFit()
    guard let imagePath = character.thumbnail?.imagePath else { return }
    headerImageView.downloadedFrom(url: imagePath)
  }
}
