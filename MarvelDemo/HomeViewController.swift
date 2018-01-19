import UIKit

class HomeViewController: UIViewController {
  @IBOutlet var collectionView: UICollectionView!
  var characters: [Character] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    fetchCharacters()
  }
  
  func fetchCharacters() {
    let api = API()
    api.getCharacters() { (response, error) in
      guard error == nil else { return }
      guard let characters = response?.data?.results else { return }
      self.characters = characters
      self.collectionView.reloadData()
    }
  }
}

extension HomeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return characters.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CharacterCollectionViewCell
    cell.setupView(name: characters[indexPath.row].name!, imagePath: (characters[indexPath.row].thumbnail?.imagePath)!)
    return cell
  }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 200)
  }
}
