import Foundation

struct Characters: Decodable {
  let code: Int?
  let copyright: String?
  let attributionText: String?
  let data: CharacterDataContainer?
}

struct CharacterDataContainer: Decodable {
  let offset: Int?
  let limit: Int?
  let total: Int?
  let count: Int?
  let results: [Character]?
}

struct Character: Decodable {
  let id: Int?
  let name: String?
  let description: String?
  let thumbnail: Thumbnail?
  let resourceURI: String?
  let comics: Comics?
  let stories: Stories?
  let events: Events?
  let series: Series?
}

struct Thumbnail: Decodable {
  let path: String?
  let `extension`: String?
  
  enum CodingKeys: String, CodingKey {
    case path = "path"
    case `extension` = "fileExtension"
  }
}

struct Comics: Decodable {
  let collectionURI: String?
  let comic: [ComicSummary]?
}

struct ComicSummary: Decodable {
  let resourceURI: String?
  let name: String?
}

struct Stories: Decodable {
  let available: Int?
  let returned: Int? //upto 20
  let collectionURI: String? ///full list of stories path
  let items: [StorySummary]?
}

struct Events: Decodable {
  let available: Int?
  let returned: Int? //upto 20
  let collectionURI: String? ///full list of stories path
  let items: [EventSummary]?
}

struct Series: Decodable {
  let available: Int?
  let returned: Int? //upto 20
  let collectionURI: String? ///full list of stories path
  let items: [SeriesSummary]?
}

struct StorySummary: Decodable {
  let resourceURI: String? //path to story resource
  let name: String?
  let type: String? //interior o cover
}

struct EventSummary: Decodable {
  let resourceURI: String?
  let name: String?
}

struct SeriesSummary: Decodable {
  let resourceURI: String?
  let name: String?
}

