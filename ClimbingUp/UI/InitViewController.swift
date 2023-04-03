import UIKit
import GameKit

class InitViewController: UIViewController {
  
  @IBOutlet weak private var musicButton: UIButton?
  @IBOutlet weak private var bestResultLabel: UILabel?
  
  private var isMuted = UserDefaultsHelper.shared.isMuted {
    didSet {
      DispatchQueue.main.async { [self] in
        if isMuted {
          musicButton?.setBackgroundImage(UIImage(named: "SoundOff"), for: .normal)
          SoundManager.shared.stopMusic()
        } else {
          musicButton?.setBackgroundImage(UIImage(named: "SoundOn"), for: .normal)
          SoundManager.shared.playBackgroundMusic()
        }
        UserDefaultsHelper.shared.isMuted = isMuted
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    bestResultLabel?.text = "BEST RESULT: \(UserDefaultsHelper.shared.level)"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    isMuted = UserDefaultsHelper.shared.isMuted
  }
  
  @IBAction func startTap(_ sender: Any) {
    guard let vc = storyboard?.instantiateViewController(withIdentifier: "game") as? GameViewController else { return }
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @IBAction func soundTap(_ sender: Any) {
    isMuted = !isMuted
  }
  
  @IBAction func infoTap(_ sender: Any) {
    guard let vc = storyboard?.instantiateViewController(withIdentifier: "info") as? InfoViewController else { return }
    self.present(vc, animated: true)
  }
  
  @IBAction func shopTap(_ sender: Any) {
    guard let vc = storyboard?.instantiateViewController(withIdentifier: "shop") as? ShopViewController else { return }
    vc.modalPresentationStyle = .overFullScreen
    self.present(vc, animated: true)
  }
  
  @available(iOS 14.0, *)
  @IBAction func scoreTap(_ sender: Any) {
    let gcVC = GKGameCenterViewController(leaderboardID: UserDefaultsKeys.leaderboardID.rawValue, playerScope: .global, timeScope: .allTime)
    gcVC.gameCenterDelegate = self
    present(gcVC, animated: true, completion: nil)
  }
}

extension InitViewController: GKGameCenterControllerDelegate {
  
  func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
    gameCenterViewController.dismiss(animated: true, completion: nil)
  }
}
