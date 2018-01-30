import UIKit

class MarvelCharactersViewController: UIViewController, MarvelCharactersDelegate {  
  @IBOutlet var collectionView: UICollectionView!
  let reuseIdentifier = "characterCell"
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
    let httpClient = HttpClient(session: session)
    collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.dataSource = dataSource
    marvelCharactersController = MarvelCharactersController(httpClient: httpClient)
    marvelCharactersController.delegate = self
    marvelCharactersController.fetchCharacters()

    collectionView.dataSource = dataSource
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

extension MarvelCharactersViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 200)
  }
}
