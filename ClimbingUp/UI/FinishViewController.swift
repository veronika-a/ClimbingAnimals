import UIKit
import GameKit

class FinishViewController: UIViewController {
  
  @IBOutlet weak var statusImage: UIImageView!
  @IBOutlet weak var bgImage: UIImageView!
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var exitButton: UIButton!
  @IBOutlet weak var musicButton: UIButton!
  @IBOutlet weak var hightLabel: UILabel?
  @IBOutlet weak var currentLabel: UILabel?
  @IBOutlet weak var coinsLabel: UILabel?
  
  let level = UserDefaultsHelper.shared.level
  var isWinning: Bool = false
  var count = 0
  var coins = 0
  
  private var isMuted = UserDefaultsHelper.shared.isMuted {
    didSet {
      DispatchQueue.main.async { [self] in
        if isMuted {
          musicButton.setBackgroundImage(UIImage(named: "SoundOff"), for: .normal)
          SoundManager.shared.stopMusic()
        } else {
          musicButton.setBackgroundImage(UIImage(named: "SoundOn"), for: .normal)
          SoundManager.shared.playBackgroundMusic()
        }
        UserDefaultsHelper.shared.isMuted = isMuted
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    isMuted = UserDefaultsHelper.shared.isMuted
    populate()
  }
  
  private func populate() {
    currentLabel?.text = "RESULT: \(count)"
    coinsLabel?.text = "\(coins)"

    switch isWinning {
    case true:
      UserDefaultsHelper.shared.level = count
      submittToLeaderboard(score: level)

      bgImage.image = UIImage(named: "bg")
      statusImage.image = UIImage(named: "youWin")
      nextButton.setImage(UIImage(named: "next"), for: .normal)
    case false:
      bgImage.image = UIImage(named: "bgGame")
      statusImage.image = UIImage(named: "gameOver")
      nextButton.setImage(UIImage(named: "again"), for: .normal)
    }
    hightLabel?.text = "BEST RESULT: \(UserDefaultsHelper.shared.level)"
    UserDefaultsHelper.shared.coins = UserDefaultsHelper.shared.coins + coins
  }
  
  func submittToLeaderboard(score: Int) {
    guard GKLocalPlayer.local.isAuthenticated else { return }
    let bestScoreInt = GKScore(leaderboardIdentifier: UserDefaultsKeys.leaderboardID.rawValue)
    bestScoreInt.value = Int64(score)
    GKScore.report([bestScoreInt]) { (error) in
      if error != nil {
        print(error!.localizedDescription)
      } else {
        print("Best Score submitted to your Leaderboard!")
      }
    }
  }
  
  @IBAction func tryAgain(_ sender: Any) {
    if let vc = navigationController?.viewControllers.filter({$0.isKind(of: GameViewController.self)}).first {
      navigationController?.popToViewController(vc, animated: true)
    }
  }
  
  @IBAction func backToMenu(_ sender: Any) {
    navigationController?.popToRootViewController(animated: true)
  }
  
  @IBAction func musicButtonTap(_ sender: UIButton) {
    isMuted = !isMuted
  }
}

