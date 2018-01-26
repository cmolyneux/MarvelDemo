import UIKit

class MarvelCharactersDetailViewViewController: UIViewController {
  @IBOutlet weak var headerImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var summaryLabel: UILabel!
  
  private let name: String
  private let summary: String
  private let image: String
  
  init(name: String?, summary: String?, image: String?) {
    self.name = name ?? ""
    self.summary = summary ?? ""
    self.image = image ?? ""
    super.init(nibName: "CharacterDetailViewController", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    summaryLabel.text = summary
    nameLabel.text = name
    summaryLabel.sizeToFit()
    headerImageView.downloadedFrom(url: URL(string: image)!)
  }
}
