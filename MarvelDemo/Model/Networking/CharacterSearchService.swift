import Foundation

class CharacterSearchService {
  let api: HttpClient!
  
  init(api: HttpClient) {
    self.api = HttpClient(session: URLSession(configuration: .default))
  }
  
  enum SearchPaths: String {
    case SearchByPartialName = "nameStartsWith"
  }
  
  func searchForCharactersWhereNameStartsWith(_ string : String, completion: @escaping ([Character]) -> Void) {
    let queryParameters = URLQueryItem(name: SearchPaths.SearchByPartialName.rawValue, value: string)
    api.load(path: "/v1/public/characters", parameters: queryParameters) { response in
      switch response {
      case .success(let result):
        completion(result as! [Character])
      case .error(let error):
        print(error)
      }
    }
  }
}
