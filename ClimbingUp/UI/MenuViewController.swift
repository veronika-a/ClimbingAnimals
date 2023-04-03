import UIKit

class MenuViewController: UIViewController {
  
  var delegate: MenuDelegate?
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func resumeTap(_ sender: Any) {
    delegate?.resume()
    self.dismiss(animated: true)
  }
  
  @IBAction func restartTap(_ sender: Any) {
    delegate?.restart()
    self.dismiss(animated: true)
  }
  
  @IBAction func shopTap(_ sender: Any) {
//    guard let vc = storyboard?.instantiateViewController(withIdentifier: "shop") as? ShopViewController else { return }
//    present(vc, animated: true)
  }
  
  @IBAction func exitTap(_ sender: Any) {
    delegate?.exit()
    self.dismiss(animated: true)
  }
}

protocol MenuDelegate {
  func resume()
  func restart()
  func exit()
}
