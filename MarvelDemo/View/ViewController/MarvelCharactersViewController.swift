import UIKit

class MarvelCharactersViewController: UIViewController, MarvelCharactersDelegate {
  @IBOutlet var collectionView: UICollectionView!
  let reuseIdentifier = "characterCell"
  var marvelCharactersController: MarvelCharactersController!
  
  lazy var dataSource: MarvelCharactersDataSource = {
    MarvelCharactersDataSource(character: [], reuseIdentifier: reuseIdentifier)
  }()
  
  var state: UIState = .Loading {
    willSet(newState) {
      update(state: newState)
    }
  }
  
  func update(state: UIState) {
    switch state {
    case .Loading:
      print("Loading")
    case .Success(let response):
      dataSource.character += response
      collectionView.reloadData()
    case .Failure(let error):
      print(error)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let api = API()
    collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.dataSource = dataSource
    marvelCharactersController = MarvelCharactersController(api: api)
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
}

extension MarvelCharactersViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 200)
  }
}
