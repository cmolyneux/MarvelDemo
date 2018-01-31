import UIKit

class MarvelCharactersViewController: UIViewController, UISearchBarDelegate, MarvelCharactersDelegate {
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet weak var characterSearchBar: UISearchBar!
  
  var characterSearchService: CharacterSearchService!
  var httpClient: HttpClient!
  
  private let reuseIdentifier = "characterCell"
  var marvelCharactersController: MarvelCharactersController!
  
  lazy var dataSource: MarvelCharactersDataSource = {
    MarvelCharactersDataSource(character: [], reuseIdentifier: reuseIdentifier)
  }()
  
  func update(state: UIState) {
    switch state {
    case .Loading:
      print("Loading")
    case .Success(let response):
      dataSource.character += response as! [Character]
      collectionView.reloadData()
    case .Failure(let error):
      print(error)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let session = URLSession(configuration: .default)
    httpClient = HttpClient(session: session)
    characterSearchService = CharacterSearchService(api: httpClient)
    
    marvelCharactersController = MarvelCharactersController(httpClient: httpClient)
    marvelCharactersController.delegate = self
    marvelCharactersController.fetchCharacters()
    characterSearchBar.delegate = self
    setupCollectionView()
  }

  func setupCollectionView() {
    collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.layoutMargins = .zero
    collectionView.dataSource = dataSource
  }
  
  func searchForItem(_ searchString: String) {
    characterSearchService.searchForCharactersWhereNameStartsWith(searchString) { result in
      self.dataSource.character = result
      self.collectionView.reloadData()
    }
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
