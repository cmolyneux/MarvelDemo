import Foundation

enum State {
  case Loading
  case Success([Any])
  case Failure(Error)
}

protocol MarvelCharactersDelegate: class {
  func update(state: State)
  func didRecieveSearchResults(state: State)
}

class MarvelCharactersModel {
  weak var delegate: MarvelCharactersDelegate?
  let characterService: CharacterService!
  let searchService: SearchService!
  
  var offset = 0
  //TODO: add limit to check whether any more characters to load
  
  init(session: URLSession) {
    self.characterService = CharacterService(session: session)
    self.searchService = SearchService(session: session)
  }
  
  var state: State = .Loading {
    didSet {
      delegate?.update(state: state)
    }
  }
  
  func requestCharacters(named searchTerm: String) {
    searchService.searchForCharactersWhereNameStartsWith(searchTerm) { response in
      switch response {
      case .success(let characters):
       self.delegate?.didRecieveSearchResults(state: .Success(characters))
      case .error(let error):
        self.delegate?.didRecieveSearchResults(state: .Failure(error))
      }
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
