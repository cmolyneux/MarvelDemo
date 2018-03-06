import UIKit
import AlamofireImage

class CharacterDetailViewController: UIViewController {
  @IBOutlet weak var headerImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var summaryLabel: UILabel!
  
  private let character: Character!
  
  init(character: Character) {
    self.character = character
    super.init(nibName: "CharacterDetailView", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    title = character.name
    let backButton = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(closeView))
    backButton.tintColor = .white
    navigationItem.setLeftBarButton(backButton, animated: false)
  }
  
  @objc func closeView() {
    navigationController?.popViewController(animated: true)
  }
  
  func setupView() {
    nameLabel.text = (character.name == "") ? "Classified: No name given" : character.name
    summaryLabel.text = (character.description == "") ? "Classified: No description given" : character.description
    summaryLabel.sizeToFit()
    guard let imagePath = character.thumbnail?.imagePath else {
      return
    }
    guard let imageUrl = URL(string: imagePath) else {
      return
    }
    headerImageView.af_setImage(withURL: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeholder"))
  }
}
