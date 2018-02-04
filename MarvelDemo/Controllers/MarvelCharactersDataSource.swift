import UIKit

class MarvelCharactersDataSource: NSObject, UICollectionViewDataSource {
  var character: [Character]
  
  init(character: [Character]) {
    self.character = character
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return character.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as! CharacterCollectionViewCell
    cell.setupView(name: character[indexPath.row].name, imagePath: character[indexPath.row].thumbnail?.imagePath)
    return cell
  }
}
