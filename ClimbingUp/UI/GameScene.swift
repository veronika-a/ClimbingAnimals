import SpriteKit
import CoreMotion

class GameScene: SKScene {
  
  private var shape: SKShapeNode?
  private var boxtimer: Timer?
  private var timer: Timer?
  private var iceNumber: Int = 0
  var vc: GameViewController?
  var item: GameСharacter?
  private let motionManager = CMMotionManager()
  private let queue = OperationQueue()
  //var background = SKSpriteNode(imageNamed: "bgGame")
  var rotation: Double?
  var block: [Block] = [Block]()
  var isGameOver = false
  var boxCounter = 0
  let cameraNode = SKCameraNode()
  var counter = 0
  var coins = 0 {
    didSet {
      vc?.coins = coins
      boxSpeed = boxSpeed - 0.1
    }
  }
  var badBoxNumber = Int.random(in: 1...10)
  var badBox: Block?
  var left: SKShapeNode?
  var right: SKShapeNode?
  var boxSpeed: TimeInterval = 5
  
  override func didMove(to view: SKView) {
//    background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
//    background.size = CGSize(width: self.size.width, height: self.size.height)
//    addChild(background)
    
    //self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    self.physicsBody?.isDynamic = false
    self.physicsBody?.affectedByGravity = false
    self.setUpScene()
    
  }
  func setUpScene() {
    setupBoxTimer()
    print("badBoxNumber \(badBoxNumber)")

    self.camera = cameraNode
    self.camera?.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
    physicsWorld.gravity = CGVector(dx: 0, dy: 0 - boxSpeed)
    physicsWorld.contactDelegate = self
    //backgroundColor = UIColor.darkGray
    setGround()
    newBlock()
  }
  
  private func setupTimer() {
    timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
  }
  
  @objc private func fireTimer() {
    guard !(scene?.isPaused ?? false) else { return }
    if item?.position.y ?? 0 <= self.frame.height / 2 {
      self.cameraNode.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
    } else {
      self.cameraNode.position = CGPoint(x: self.cameraNode.position.x, y: item?.position.y ?? 0 / 2)
    }
  }
  
  private func setupBoxTimer() {
    boxtimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(fireBoxTimer), userInfo: nil, repeats: true)
  }
  
  @objc private func fireBoxTimer() {
    guard !(scene?.isPaused ?? false) else { return }
    guard let last = block.last else { return }
    left?.position = CGPoint(x: last.position.x - last.frame.width / 2 - 1, y: last.position.y - last.frame.height / 2)
    right?.position = CGPoint(x: last.position.x + last.frame.width / 2 + 2, y: last.position.y - last.frame.height / 2)

  }
  
  private func setGround() {
    let node = SKShapeNode(rect: CGRect(x: 0, y: 0, width: view?.frame.width ?? 0, height: 2))
    node.strokeColor = .clear
    node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: view?.frame.width ?? 0, height: 2), center:  CGPoint(x: node.frame.width / 2, y: node.frame.height / 2))
    node.physicsBody?.affectedByGravity = false
    node.physicsBody?.mass = 1000
    node.physicsBody?.isDynamic = false
    node.physicsBody?.categoryBitMask = BitMaskCategory.ground.rawValue
    node.physicsBody?.collisionBitMask = BitMaskCategory.block.rawValue | BitMaskCategory.item.rawValue
    node.position = CGPoint(x: 0, y: 0)
    addChild(node)
    shape = node
                           
    let item = GameСharacter(category: GameСharacter.СharacterType(rawValue: UserDefaultsHelper.shared.current) ?? .first)
    let itemPosition = CGPoint(x: frame.width / 2, y: node.position.y + node.frame.height + item.frame.height / 2)
    item.position = itemPosition
    self.addChild(item)
    self.item = item
  }
  
  func newBlock() {
    let rand = Bool.random()
    let number = self.iceNumber
    let randEl = Block.BlockType.allCases.randomElement() ?? .first
    let ice = Block(category: randEl, number: number, rect: self.frame, isBadBox: badBoxNumber == iceNumber)
    if badBoxNumber == iceNumber {
      badBoxNumber = Int.random(in: (iceNumber + 5)...(iceNumber + 15))
      print("badBoxNumber \(badBoxNumber)")
    }
    var y = (shape?.frame.height ?? 0) + (shape?.position.y ?? 0) + ice.frame.height / 2
    if !block.isEmpty, let last = block.last {
      y = last.position.y + last.frame.height / 2 + ice.frame.height / 2 + 2
    }
    let positionX = rand ? self.size.width + ice.frame.width / 2 : 0 - ice.frame.width / 2
    
    ice.position = CGPoint(x: positionX, y: y)
    
    let left = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 1, height: (ice.frame.height / 2)))
    left.strokeColor = .clear
    left.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: left.frame.height), center: CGPoint(x: left.position.y - left.frame.width / 2 - 1, y: left.position.y + left.frame.height))
    left.physicsBody?.affectedByGravity = false
    left.physicsBody?.mass = 1000
    left.physicsBody?.allowsRotation = false
    left.physicsBody?.categoryBitMask = BitMaskCategory.line.rawValue
    left.physicsBody?.collisionBitMask = BitMaskCategory.item.rawValue
    left.physicsBody?.contactTestBitMask = BitMaskCategory.item.rawValue
    left.position = CGPoint(x: ice.position.x - ice.frame.width / 2 - 1, y: ice.position.y - ice.frame.height / 2)
    
    let right = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 1, height: (ice.frame.height / 2)))
    right.strokeColor = .clear
    right.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: right.frame.height), center: CGPoint(x: ice.position.x + ice.frame.width / 2 + 2, y: right.position.y + right.frame.height))
    right.physicsBody?.affectedByGravity = false
    right.physicsBody?.mass = 1000
    right.physicsBody?.allowsRotation = false
    right.physicsBody?.categoryBitMask = BitMaskCategory.line.rawValue
    right.physicsBody?.collisionBitMask = BitMaskCategory.item.rawValue
    right.physicsBody?.contactTestBitMask = BitMaskCategory.item.rawValue
    right.position = CGPoint(x: ice.position.x + ice.frame.width / 2 + 1, y: ice.position.y - ice.frame.height / 2)
    
    let move = SKAction.move(to: CGPoint(x: rand ? 0 - ice.frame.size.width : self.size.width + ice.frame.width / 2, y: ice.position.y), duration: 5)
    ice.run(move) { [weak self] in
      guard let self  = self else { return }
      self.left?.removeFromParent()
      self.left = nil
      self.right?.removeFromParent()
      self.right = nil
      if !ice.isBadBox {
        self.gameOver()
      } else {
        self.newBlock()
      }
    }
    if !ice.isBadBox {
      block.append(ice)
      self.addChild(block.last!)
      iceNumber = iceNumber + 1
      self.left = left
      addChild(self.left!)
      self.right = right
      addChild(self.right!)
    } else {
      badBox = ice
      self.addChild(badBox!)
    }
  }
  
  func newCoin() {
    let texture = SKTexture(imageNamed: "coin")
    let node = SKSpriteNode(texture: texture, size: texture.size())
    node.setScale(toWidth: 30)
    node.physicsBody = SKPhysicsBody(texture: node.texture!, size: node.size)
    node.physicsBody?.affectedByGravity = false
    node.physicsBody?.mass = 10
    node.physicsBody?.isDynamic = false
    node.physicsBody?.categoryBitMask = BitMaskCategory.coin.rawValue
    node.physicsBody?.collisionBitMask = 0
    if !block.isEmpty, let last = block.last {
      node.position = CGPoint(x: frame.width / 2, y: last.position.y + last.frame.height * 4)
      addChild(node)
    }
   
  }
  
  private func gameOver() {
    guard !isGameOver else { return }
    isGameOver = true
    self.removeAllActions()
    self.removeAllChildren()
    vc?.gameOver(count: counter)
    print("counter \(counter)")
  }
  
  func jump() {
    item?.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 10000.0 ))
    if timer == nil, item?.position.y ?? 0 > frame.height / 2 {
      self.setupTimer()
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    jump()
  }
  
}

extension GameScene: SKPhysicsContactDelegate {
  
  func didBegin(_ contact: SKPhysicsContact) {
    let bodyA = contact.bodyA
    let bodyB = contact.bodyB
    
    if bodyA.node?.physicsBody?.categoryBitMask != bodyB.node?.physicsBody?.categoryBitMask {
      if let _ = bodyA.node as? GameСharacter, bodyB.node?.physicsBody?.categoryBitMask == BitMaskCategory.line.rawValue {
        gameOver()
      } else if let _ = bodyB.node as? GameСharacter, bodyA.node?.physicsBody?.categoryBitMask == BitMaskCategory.line.rawValue {
        gameOver()
      }
      if let _ = bodyA.node as? GameСharacter, let node = bodyB.node as? Block {
        blockContact(node: node)
      } else if let _ = bodyB.node as? GameСharacter, let node = bodyA.node as? Block {
        blockContact(node: node)
      }
      if let _ = bodyB.node as? GameСharacter, bodyA.node?.physicsBody?.categoryBitMask == BitMaskCategory.coin.rawValue {
        getCoin(coin: bodyA.node)
      } else if let _ = bodyA.node as? GameСharacter, bodyB.node?.physicsBody?.categoryBitMask == BitMaskCategory.coin.rawValue {
        getCoin(coin: bodyB.node)
      }
      if bodyA.node?.physicsBody?.categoryBitMask == BitMaskCategory.ground.rawValue || bodyB.node?.physicsBody?.categoryBitMask == BitMaskCategory.ground.rawValue {
        if bodyA.node?.physicsBody?.categoryBitMask == BitMaskCategory.item.rawValue || bodyB.node?.physicsBody?.categoryBitMask == BitMaskCategory.item.rawValue {
          if block.count > 1 {
            gameOver()
          }
        }
        if let block = bodyA.node as? Block {
          if Int(block.name ?? "0") ?? 0 > 0, !block.isBadBox {
            gameOver()
          }
        } else if let block = bodyB.node as? Block {
          if Int(block.name ?? "0") ?? 0 > 0, !block.isBadBox {
            gameOver()
          }
        }
      }
    }
  }
  
  private func getCoin(coin: SKNode?) {
    item?.physicsBody?.isDynamic = false
    coin?.removeFromParent()
    coins = coins + 1
    self.left?.removeFromParent()
    self.left = nil
    self.right?.removeFromParent()
    self.right = nil
    if badBox != nil {
      badBox?.removeFromParent()
      badBox = nil
      if let last = block.last, last.isPlaced {
        newBlock()
      }
    }
    for i in 0..<block.count {
      self.block[i].removeAllActions()
      block[i].zRotation = 0
      self.block[i].physicsBody?.isDynamic = false
      let moveCenter = SKAction.move(to: CGPoint(x: frame.width / 2, y: block[i].position.y), duration: 1)
      block[i].run(moveCenter) { [weak self] in
        guard let self = self else { return }
        if i == self.block.count - 1 {
          self.item?.physicsBody?.isDynamic = true
        }
      }
    }
  }
  
  private func blockContact(node: Block) {
    guard !node.isBadBox else {
      gameOver()
      return
    }
    guard !node.isPlaced else { return }
    var number: Int? = nil
    block.forEach({ if $0.name == node.name { number = Int($0.name ?? "")} })
    guard let number = number else { return }
    self.left?.removeFromParent()
    self.left = nil
    self.right?.removeFromParent()
    self.right = nil
    block[number].removeAllActions()
    block[number].physicsBody?.isDynamic = true
    block[number].physicsBody?.affectedByGravity = true
    block[number].isPlaced = true
    counter = counter + 1
    let shouldMoveToCenterCount = (2 + boxCounter) * boxCounter
    if iceNumber > shouldMoveToCenterCount {
      print("shouldMoveToCenterCount \(shouldMoveToCenterCount)")
      boxCounter = boxCounter + 1
      newCoin()
    }
    self.newBlock()
  }
}
