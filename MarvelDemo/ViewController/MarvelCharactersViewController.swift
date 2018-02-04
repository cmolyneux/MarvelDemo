import UIKit

class MarvelCharactersViewController: UIViewController, UISearchBarDelegate, MarvelCharactersDelegate {
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet weak var characterSearchBar: UISearchBar!
  
  var marvelCharactersController: MarvelCharactersController!

  lazy var dataSource: MarvelCharactersDataSource = {
    MarvelCharactersDataSource(character: [])
  }()
  
  func update(state: State) {
    switch state {
    case .Loading:
      print("Loading")
    case .Success(let response):
      dataSource.character = response as! [Character]
      collectionView.reloadData()
    case .Failure(let error):
      print(error)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let session = URLSession(configuration: .default)
    marvelCharactersController = MarvelCharactersController(session: session)
    marvelCharactersController.delegate = self
    marvelCharactersController.fetchCharacters()
    characterSearchBar.delegate = self
    setupCollectionView()
  }

  func setupCollectionView() {
    collectionView.register(CharacterCollectionViewCell.nib, forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
    collectionView.dataSource = dataSource
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
    flowLayout.minimumLineSpacing = 0
    collectionView.collectionViewLayout = flowLayout
  }
  
  func searchForItem(_ searchString: String) {
    marvelCharactersController.requestCharacters(named: searchString)
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.count > 3 {
      searchForItem(searchText)
    }
  }
}

extension MarvelCharactersViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if indexPath.row == dataSource.character.count - 1 {
      marvelCharactersController.fetchCharacters()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let character = dataSource.character[indexPath.row]
    let vc = MarvelCharacterDetailViewController(character: character)
    navigationController?.pushViewController(vc, animated: true)
  }
}
