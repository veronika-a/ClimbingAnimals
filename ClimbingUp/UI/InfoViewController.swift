import UIKit

class InfoViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //UserDefaultsHelper.shared.coins = UserDefaultsHelper.shared.coins + 40
  }
  
  @IBAction func backTap(_ sender: Any) {
    dismiss(animated: true)
  }
}
