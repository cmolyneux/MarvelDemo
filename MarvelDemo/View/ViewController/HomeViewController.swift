import UIKit

class HomeViewController: UIViewController, MarvelCharactersDelegate {
  @IBOutlet var collectionView: UICollectionView!
  var characters: [Character] = []
  var offset: Int = 0
  var marvelCharactersController: MarvelCharactersController!
  var marvelCharactersHandler: MarvelCharactersHandler!
  
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
      characters += response
      collectionView.reloadData()
    case .Failure(let error):
      print(error)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    marvelCharactersController = MarvelCharactersController()
    marvelCharactersController.delegate = self
    marvelCharactersController.fetchCharacters(with: offset)
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
      marvelCharactersController.fetchCharacters(with: offset)
    }
  }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 200)
  }
}
