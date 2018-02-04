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
  case success([Any])
  case error(Error)
}

class HttpClient {
  let session: URLSession
  
  var authParameters: [String: String] {
    return ["apikey": APIConfig.apikey,
            "ts": APIConfig.ts,
            "hash": APIConfig.hash]
  }
  
  init(session: URLSession) {
    self.session = session
  }
  
  var baseUrlWithAuthorisation: URLComponents {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "gateway.marvel.com"
    components.queryItems = authParameters.map { URLQueryItem(name: $0, value: $1) }
    return components
  }
  
  //WIP 
  func load(path: String, parameters: URLQueryItem, completion: @escaping (Response) -> Void) {
    var components = baseUrlWithAuthorisation
    components.path = path
    components.queryItems?.append(parameters)

    guard let urlString = components.string else { return }
    guard let url = URL(string: urlString) else { return }
    
    session.dataTask(with: url, completionHandler: {
      (data, response, error) in
      DispatchQueue.main.async {
        guard error == nil else { return }
        guard let data = data else { return }
        
        do {
          let decoder = JSONDecoder()
          let characters = try decoder.decode(Characters.self, from: data)
          guard let result = characters.data?.results else { return }
          completion(.success(result))
        } catch {
          completion(.error(error))
        }
      }
    }).resume()
  }
}
