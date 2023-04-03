import SpriteKit

class GameСharacter: SKSpriteNode {
  var type: СharacterType?

  enum СharacterType: Int, CaseIterable {
    case first = 0, second, third, fourth, fifth, sixth, seventh
    
    var image: String {
      switch self {
        case .first:
          return "item1"
        case .second:
          return "item2"
        case .third:
          return "item3"
        case .fourth:
          return "item4"
        case .fifth:
          return "item5"
        case .sixth:
          return "item6"
        case .seventh:
          return "item7"
      }
    }
    
    var weight: CGFloat {
      switch self {
        case .first:
          return 75
        case .second:
          return 70
        case .third:
          return 85
        case .fourth:
          return 80
        case .fifth:
          return 110
        case .sixth:
          return 80
        case .seventh:
          return 75
      }
    }
    
    var money: Int {
      switch self {
        case .first:
          return 0
        case .second:
          return 40
        case .third:
          return 40
        case .fourth:
          return 100
        case .fifth:
          return 200
        case .sixth:
          return 60
        case .seventh:
          return 120
      }
    }
    
    var isBought: Bool {
      switch self {
        case .first: return true
        case .second:  return UserDefaultsHelper.shared.second
        case .third: return UserDefaultsHelper.shared.third
        case .fourth: return UserDefaultsHelper.shared.fourth
        case .fifth: return UserDefaultsHelper.shared.fifth
        case .sixth: return UserDefaultsHelper.shared.sixth
        case .seventh: return UserDefaultsHelper.shared.seventh
      }
    }
    
    var contactForAll: UInt32 {
      BitMaskCategory.ground.rawValue
    }
  }
  
  init(category: СharacterType) {
    let texture = SKTexture(imageNamed: category.image)
    self.type = category
    super.init(texture: texture, color: UIColor.clear, size: texture.size())
    self.texture = texture
    self.setScale(toWidth: category.weight)
    self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: self.frame.height))

    self.physicsBody?.affectedByGravity = true
    self.physicsBody?.allowsRotation = true
    self.physicsBody?.isDynamic = true
    self.physicsBody?.mass = 20
    self.physicsBody?.restitution = 0
    self.physicsBody?.categoryBitMask = BitMaskCategory.item.rawValue
    self.physicsBody?.contactTestBitMask = BitMaskCategory.ground.rawValue | BitMaskCategory.coin.rawValue | BitMaskCategory.block.rawValue | BitMaskCategory.line.rawValue
    self.physicsBody?.collisionBitMask = BitMaskCategory.ground.rawValue | BitMaskCategory.block.rawValue | BitMaskCategory.line.rawValue

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
