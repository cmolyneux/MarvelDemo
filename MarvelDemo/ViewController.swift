import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let api = API()
    api.getCharacters() { response in
      print(response)
    }
  }
}

