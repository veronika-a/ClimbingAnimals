import UIKit

class ShopCell: UICollectionViewCell, SelfConfiguringCell {
  static var reuseId: String = "ShopCell"
  
  @IBOutlet private weak var image: UIImageView!
  @IBOutlet private weak var money: UILabel!
  
  func configure(with item: GameСharacter.СharacterType, isBought: Bool = false) {
    image.image = UIImage(named: item.image)
    money.text = "\(item.money)"
    image.alpha = isBought == true ? 0.5 : 1
  }
  
}

protocol SelfConfiguringCell {
  static var reuseId: String { get }
  func configure(with item: GameСharacter.СharacterType, isBought: Bool)
}
