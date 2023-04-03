enum BitMaskCategory: UInt32, CaseIterable {
  case ground, block, item, coin, line
  
  var rawValue: UInt32 {
    switch self {
      case .ground:
        return  0x1 << 0
      case .block:
        return  0x1 << 1
      case .coin:
        return  0x1 << 2
      case .item:
        return  0x1 << 3
      case .line:
        return  0x1 << 4
    }
  }
}
