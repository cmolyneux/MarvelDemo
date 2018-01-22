import Foundation

enum UIState {
  case Loading
  case Success([Character])
  case Failure(Error)
}

protocol MarvelCharactersDelegate: class {
  var state: UIState { get set }
}

final class MarvelCharactersController {
  var delegate: MarvelCharactersDelegate?
  let api: API!
  
  init(api: API) {
    self.api = api
  }
  
  func fetchCharacters(with offset: Int?) {
    guard let delegate = delegate else { return }
    delegate.state = .Loading
    
    api.getCharacters(with: offset) { response in
      switch response {
      case .success(let model):
        guard let characters = model as? Characters else { return }
        guard let results = characters.data?.results else { return }
        delegate.state = .Success(results)
      case .error(let error):
        delegate.state = .Failure(error)
      }
    }
  }
}

//Not using this yet
protocol MarvelCharactersHandler {
  var delegate: MarvelCharactersDelegate? { get set }
  func fetchCharacters(with offset: Int?)
}
