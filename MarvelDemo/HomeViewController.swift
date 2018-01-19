import UIKit

class HomeViewController: UIViewController {
  @IBOutlet var collectionView: UICollectionView!
  let api = API()
  var characters: [Character] = []
  var limit: Int!
  var offset: Int = 0
  var isLoadingMoreCharacters: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    fetchCharacters()
  }
  
  func fetchCharacters(with offset: Int? = nil) {
    if isLoadingMoreCharacters == false {
      isLoadingMoreCharacters = true
      api.getCharacters(with: offset) { (response) in
        switch response {
        case .success(let model):
          guard let characters = model as? Characters else { return }
          guard let results = characters.data?.results else { return }
          self.characters += results
          self.collectionView.reloadData()
        case .error(let err):
          print(err)
        }
        self.isLoadingMoreCharacters = false
      }
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

extension HomeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if indexPath.row == characters.count - 1 {
      offset = offset + 20
      fetchCharacters(with: offset)
    }
  }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 200)
  }
}
