import UIKit

struct CharactersDataSource {
  var charactersDataSource: MarvelCharactersDataSource = MarvelCharactersDataSource(character: [])
  var searchDataSource: MarvelCharactersDataSource = MarvelCharactersDataSource(character: [])
}

class CharactersViewController: UIViewController, UISearchBarDelegate, MarvelCharactersDelegate {
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet weak var characterSearchBar: UISearchBar!
  
  var marvelCharactersHandler: MarvelCharactersHandler!
  var dataSource: CharactersDataSource = CharactersDataSource()
  var isSearch: Bool = false

  func update(state: State) {
    switch state {
    case .Loading:
      print("Loading")
    case .Success(let response):
      isSearch = false
      dataSource.charactersDataSource.character += response as! [Character]
      collectionView.reloadData()
    case .Failure(let error):
      print(error)
    }
  }
  
  func didRecieveSearchResults(state: State) {
    switch state {
    case .Loading:
      print("Loading")
    case .Success(let response):
      isSearch = true
      dataSource.searchDataSource.character = response as! [Character]
      collectionView.dataSource = dataSource.searchDataSource
      collectionView.reloadData()
    case .Failure(let error):
      print(error)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let session = URLSession(configuration: .default)
    marvelCharactersHandler = MarvelCharactersHandler(characterService: CharacterService(session: session), searchService: SearchService(session: session))
    marvelCharactersHandler.delegate = self
    marvelCharactersHandler.fetchCharacters()
    characterSearchBar.delegate = self
    setupCollectionView()
  }

  func setupCollectionView() {
    collectionView.register(CharacterCollectionViewCell.nib, forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
    collectionView.dataSource = dataSource.charactersDataSource
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
    flowLayout.minimumLineSpacing = 0
    collectionView.collectionViewLayout = flowLayout
  }
  
  func searchForItem(_ searchString: String) {
    marvelCharactersHandler.fetchCharacters(named: searchString)
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.count > 3 {
      searchForItem(searchText)
    } else {
      collectionView.dataSource = dataSource.charactersDataSource
      marvelCharactersHandler.fetchCharacters()
    }
  }
}

extension CharactersViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if indexPath.row == dataSource.charactersDataSource.character.count - 1 {
      marvelCharactersHandler.fetchCharacters()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let character = isSearch ? dataSource.searchDataSource.character[indexPath.row] : dataSource.charactersDataSource.character[indexPath.row]
    let viewController = CharacterDetailViewController(character: character)
    navigationController?.pushViewController(viewController, animated: true)
  }
}
