import UIKit

class MarvelCharactersDataSource: NSObject, UICollectionViewDataSource {
  var character: [Character]
  let reuseIdentifier: String
  
  init(character: [Character], reuseIdentifier: String) {
    self.character = character
    self.reuseIdentifier = reuseIdentifier
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return character.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
    cell.setupView(name: character[indexPath.row].name, imagePath: character[indexPath.row].thumbnail?.imagePath)
    return cell
  }
}
