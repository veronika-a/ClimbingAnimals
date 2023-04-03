import UIKit
import GameKit

extension Double {
  func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
    formatter.unitsStyle = style
    return formatter.string(from: self) ?? ""
  }
}

// Screen width.
public var screenWidth: CGFloat {
  return UIScreen.main.bounds.width
}

// Screen height.
public var screenHeight: CGFloat {
  return UIScreen.main.bounds.height
}

extension SKSpriteNode {
  func setScale(toWidth: CGFloat) {
    self.setScale(1)
    let ration = toWidth / self.frame.width
    self.setScale(ration)
  }
  
  func setScale(toHeight: CGFloat) {
    self.setScale(1)
    let ration = toHeight / self.frame.height
    self.setScale(ration)
  }
}

extension CGRect {
  func rangeByX() -> ClosedRange<CGFloat> {
    return (minX...maxX)
  }
  
  func rangeByY() -> ClosedRange<CGFloat> {
    return (minY...maxY)
  }
}

extension UIImage {
  static func gradientImage(withBounds: CGRect, startPoint: CGPoint, endPoint: CGPoint , colors: [CGColor]) -> UIImage {
    
    // Configure the gradient layer based on input
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = withBounds
    gradientLayer.colors = colors
    gradientLayer.startPoint = startPoint
    gradientLayer.endPoint = endPoint
    gradientLayer.cornerRadius = 10
    
    // Render the image using the gradient layer
    UIGraphicsBeginImageContext(gradientLayer.bounds.size)
    gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
  }
}
