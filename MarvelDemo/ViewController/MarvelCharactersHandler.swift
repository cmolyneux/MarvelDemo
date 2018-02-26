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

//This will probably all go / be simplified
class MarvelCharactersHandler {
  weak var delegate: MarvelCharactersDelegate?
  let characterService: CharacterService!
  let searchService: SearchService!
  
  //TODO: add limit to check whether there are any more characters to fetch
  var offset = 0
  
  init(characterService: CharacterService, searchService: SearchService) {
    self.characterService = characterService
    self.searchService = searchService
  }
  
  var state: State = .Loading {
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
  
  func fetchCharacters(named searchTerm: String) {
    searchService.searchForCharactersWhereNameStartsWith(searchTerm) { response in
      switch response {
      case .success(let characters):
       self.delegate?.didRecieveSearchResults(state: .Success(characters))
      case .error(let error):
        self.delegate?.didRecieveSearchResults(state: .Failure(error))
      }
    }
  }
}
