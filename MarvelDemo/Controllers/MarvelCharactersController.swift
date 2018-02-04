import Foundation

enum UIState {
  case Loading
  case Success([Any])
  case Failure(Error)
}

protocol MarvelCharactersDelegate: class {
  func update(state: UIState)
}

class MarvelCharactersController {
  weak var delegate: MarvelCharactersDelegate?
  let characterService: CharacterService!
  
  var offset = 0 //add limit to check whether any more characters to load
  
  init(session: URLSession) {
    self.characterService = CharacterService(session: session)
  }
  
  var state: UIState = .Loading {
    didSet {
      delegate?.update(state: state)
    }
  }
  
  func fetchCharacters() {
    state = .Loading
    characterService.getCharacters(with: offset) { response in
      switch response {
      case .success(let characters):
        self.offset += 20
        self.state = .Success(characters)
      case .error(let error):
        self.state = .Failure(error)
      }
    }
  }
}
