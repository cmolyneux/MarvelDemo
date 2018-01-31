import Foundation

class CharacterService {
  private let characterServicePath = "/v1/public/characters"
  let api: HttpClient!
  
  init(api: HttpClient) {
    self.api = HttpClient(session: URLSession(configuration: .default))
  }
  
  func getCharacters(with offset: Int, completion: @escaping (Response) -> Void) {
    let queryItems = URLQueryItem(name: "offset", value: String(offset))
    api.load(path: characterServicePath, parameters: queryItems) { response in
      completion(response)
    }
  }
}
