import Foundation

public enum UserDefaultsKeys: String, CaseIterable {
  case level
  case isMuted
  case coins
  case second, third, fourth, fifth, sixth, seventh
  case current
  case leaderboardID
}

class UserDefaultsHelper {
  static let shared = UserDefaultsHelper()
  
  var coins: Int {
    get {
      return UserDefaults.standard.integer(forKey: UserDefaultsKeys.coins.rawValue)
    }
    set {
      guard newValue > 0 else { return }
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.coins.rawValue)
    }
  }
  
  var level: Int {
    get {
      return UserDefaults.standard.integer(forKey: UserDefaultsKeys.level.rawValue)
    }
    set {
      guard newValue > 0 else { return }
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.level.rawValue)
    }
  }
  
  var current: Int {
    get {
      return UserDefaults.standard.integer(forKey: UserDefaultsKeys.current.rawValue)
    }
    set {
      guard newValue >= 0 else { return }
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.current.rawValue)
    }
  }
  
  var isMuted: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isMuted.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isMuted.rawValue)
    }
  }
  
  var second: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.second.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.second.rawValue)
    }
  }
  
  var third: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.third.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.third.rawValue)
    }
  }
  
  var fourth: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.fourth.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.fourth.rawValue)
    }
  }
  
  var fifth: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.fifth.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.fifth.rawValue)
    }
  }
  
  var sixth: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.sixth.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.sixth.rawValue)
    }
  }
  
  var seventh: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.seventh.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.seventh.rawValue)
    }
  }
  
  init() {
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.level.rawValue : 0])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.coins.rawValue : 0])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.current.rawValue : 0])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.isMuted.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.second.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.third.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.fourth.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.fifth.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.sixth.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.seventh.rawValue : false])
  }
}
