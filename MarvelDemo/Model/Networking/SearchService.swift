import Foundation

class SearchService {
  let api: HttpClient!
  
  init(session: URLSession) {
    self.api = HttpClient(session: session)
  }
  
  enum SearchPaths: String {
    case SearchByPartialName = "nameStartsWith"
  }
  
  func searchForCharactersWhereNameStartsWith(_ string : String, completion: @escaping (Response) -> Void) {
    let queryParameters = URLQueryItem(name: SearchPaths.SearchByPartialName.rawValue, value: string)
    api.load(path: "/v1/public/characters", parameters: queryParameters) { response in
      completion(response)
    }
  }
}
