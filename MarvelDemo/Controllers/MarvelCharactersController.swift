import Foundation

enum UIState {
  case Loading
  case Success([Character])
  case Failure(Error)
}

protocol MarvelCharactersDelegate: class {
  var state: UIState { get set }
}

class MarvelCharactersController {
  weak var delegate: MarvelCharactersDelegate?
  let api: API!
  var offset = 0
  
  init(api: API) {
    self.api = api
  }
  
  func fetchCharacters() {
    guard let delegate = delegate else { return }
    delegate.state = .Loading
    
    api.getCharacters(with: offset) { response in
      switch response {
      case .success(let model):
        guard let characters = model as? Characters else { return }
        guard let results = characters.data?.results else { return }
        self.offset += 20
        delegate.state = .Success(results)
      case .error(let error):
        delegate.state = .Failure(error)
      }
    }
  }
}
