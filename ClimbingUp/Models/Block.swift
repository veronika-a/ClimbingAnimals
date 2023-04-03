import SpriteKit

class Block: SKSpriteNode {
  var type: BlockType?
  let startPoint = CGPoint(x: 0, y: 0)
  let endPoint = CGPoint(x: 1, y: 1)
  var isPlaced = false
  var isBadBox = false

  enum BlockType: Int, CaseIterable {
    case first = 0, second, third, fourth, fifth, sixth, seventh, eight, nine
    
    var bitMask: BitMaskCategory {
      return .block
    }
    
    var height: Int {
      switch self {
        case .first:
          return 60
        case .second:
          return 70
        case .third:
          return 50
        case .fourth:
          return 60
        case .fifth:
          return 50
        case .sixth:
          return 70
        case .seventh:
          return 80
        case .eight:
          return 50
        case .nine:
          return 90
      }
    }
    
    var width: Int {
      switch self {
        case .first:
          return 100
        case .second:
          return 90
        case .third:
          return 70
        case .fourth:
          return 100
        case .fifth:
          return 80
        case .sixth:
          return 100
        case .seventh:
          return 80
        case .eight:
          return 140
        case .nine:
          return 50
      }
    }
    
    var firstColor: CGColor {
      switch self {
        case .first:
          return UIColor.yellow.cgColor
        case .second:
          return UIColor.blue.cgColor
        case .third:
          return UIColor.red.cgColor
        case .fourth:
          return UIColor.purple.cgColor
        case .fifth:
          return UIColor.orange.cgColor
        case .sixth:
          return UIColor.green.cgColor
        case .seventh:
          return UIColor.magenta.cgColor
        case .eight:
          return UIColor.cyan.cgColor
        case .nine:
          return UIColor.yellow.cgColor
      }
    }
    
    var secondColor: CGColor {
      switch self {
        case .first:
          return UIColor.magenta.cgColor
        case .second:
          return UIColor.orange.cgColor
        case .third:
          return UIColor.green.cgColor
        case .fourth:
          return UIColor.blue.cgColor
        case .fifth:
          return UIColor.yellow.cgColor
        case .sixth:
          return UIColor.red.cgColor
        case .seventh:
          return UIColor.purple.cgColor
        case .eight:
          return UIColor.red.cgColor
        case .nine:
          return UIColor.magenta.cgColor
      }
    }
    
    var contactForAll: UInt32 {
      BitMaskCategory.ground.rawValue
    }
  }
  
  init(category: BlockType, number: Int, rect: CGRect, isBadBox: Bool = false) {
    self.isBadBox = isBadBox
    let image: UIImage =
    isBadBox ? UIImage.gradientImage(withBounds: CGRect(x: 0, y: 0, width: category.width, height: category.height), startPoint: startPoint, endPoint: endPoint, colors: [UIColor.red.cgColor, UIColor.black.cgColor]) :
    UIImage.gradientImage(withBounds: CGRect(x: 0, y: 0, width: category.width, height: category.height), startPoint: startPoint, endPoint: endPoint, colors: [category.firstColor, category.secondColor])
    let gradientTexture = SKTexture(image: image)
    super.init(texture: gradientTexture, color: .clear, size: gradientTexture.size())
    setScale(toWidth: CGFloat(category.width))
    self.name = "\(number)"
    self.texture = gradientTexture
    self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
    self.physicsBody?.isDynamic = false
    self.physicsBody?.restitution = 0
    self.physicsBody?.mass = 2000
    self.physicsBody?.categoryBitMask = BitMaskCategory.block.rawValue
    self.physicsBody?.contactTestBitMask = BitMaskCategory.ground.rawValue | BitMaskCategory.item.rawValue
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
