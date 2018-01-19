import Foundation
import CryptoSwift
import Keys

private struct APIConfig {
  private static let keys = MarvelKeys()
  static let privateKey = keys.marvelPrivateKey
  static let apikey = keys.marvelApiKey
  static let ts = Date().timeIntervalSince1970.description
  static let hash = "\(ts)\(privateKey)\(apikey)".md5()
}

enum Response {
  case success(Any)
  case error(Error)
}


class API {
  var parameters: [String: String] {
    return ["apikey": APIConfig.apikey,
            "ts": APIConfig.ts,
            "hash": APIConfig.hash]
  }
  
  func getCharacters(completion: @escaping (Response) -> Void) {
    let session = URLSession(configuration: .default)
    
    var components = URLComponents()
    components.scheme = "https"
    components.host = "gateway.marvel.com"
    components.path = "/v1/public/characters"
    components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
    guard let urlString = components.string else { return }
    guard let url = URL(string: urlString) else { return }
    
    session.dataTask(with: url, completionHandler: {
      (data, response, error) in
      guard error == nil else { return }
      guard let data = data else { return }
      
      do {
        let decoder = JSONDecoder()
        let characters = try decoder.decode(Characters.self, from: data)
        completion(.success(characters))
      } catch {
        print("error converting data to JSON")
        print(error)
        completion(.error(error))
      }
    }).resume()
  }
  
}
