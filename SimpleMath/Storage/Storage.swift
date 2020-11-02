//  SimpleMath
//  Copyright (c) Filip Lazov 2020
//  MIT license - see LICENSE file for more info

import Foundation

protocol Storage: AnyObject {
  var settingsBundle: SettingsBundle { get set }
  var onboardingBundle: OnboardingBundle { get set }
  
  func save() throws
}
