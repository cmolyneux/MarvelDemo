import Foundation

class CharacterService {
  private let characterServicePath = "/v1/public/characters"
  private let api: HttpClient!
  
  init(session: URLSession) {
    self.api = HttpClient(session: session)
  }
  
  func getCharacters(with offset: Int, completion: @escaping (Response) -> Void) {
    let queryItems = URLQueryItem(name: "offset", value: String(offset))
    api.load(path: characterServicePath, parameters: queryItems) { response in
      completion(response)
    }
  }
}
