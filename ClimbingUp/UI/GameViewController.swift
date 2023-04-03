import UIKit
import GameKit

class GameViewController: UIViewController {
  @IBOutlet weak private var countLabel: UILabel?
  @IBOutlet weak private var gameView: SKView?
  
  var coins: Int = 0 {
    didSet {
      countLabel?.text = "\(coins)"
    }
  }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    newGame()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    newGame()
  }
  
  func newGame() {
    //setupTimer()
    if let skView = gameView as! SKView? {
      //skView.showsPhysics = true
      skView.backgroundColor = .clear

      let scene = GameScene()
      scene.backgroundColor = .clear
      scene.vc = self
      scene.isGameOver = false
      scene.scaleMode = .resizeFill
      skView.allowsTransparency = true
      //skView.showsNodeCount = true
      skView.presentScene(scene)
    }
  }
  
  func gameOver(count: Int) {
    let scene = SKScene()
    scene.backgroundColor = .clear
    gameView?.presentScene(scene)
    let won = UserDefaultsHelper.shared.level < count
    won ? SoundManager.shared.playSound(name: "win.mp3") : SoundManager.shared.playSound(name: "falling.wav")
    let vc = storyboard?.instantiateViewController(withIdentifier: "finish") as! FinishViewController
    vc.isWinning = won
    vc.count = count
    vc.coins = coins
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  @IBAction func backButtonTap(_ sender: UIButton) {
    let scene = SKScene()
    scene.backgroundColor = .clear
    gameView?.presentScene(scene)
    navigationController?.popViewController(animated: true)
  }
  
}
