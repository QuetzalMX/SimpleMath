//  SimpleMath
//  Copyright (c) Filip Lazov 2020
//  MIT license - see LICENSE file for more info

import Foundation

final class UserDefaultsStorage {
  
  let modelVersion: String
  let key: String
  var settingsBundle: SettingsBundle
  var onboardingBundle: OnboardingBundle
  
  init(withKey: String = App.identifier, modelVersion: String) {
    key = withKey
    
    self.modelVersion = modelVersion
    
    // Do we have the previous data in UserDefaults?
    let migrationData: MigrationData
    if let savedJSONData = UserDefaults.standard.value(forKey: key) as? Data {
      migrationData = try! JSONDecoder().decode(MigrationData.self, from: savedJSONData)
      settingsBundle = migrationData.settingsBundle
      onboardingBundle = migrationData.onboardingBundle
    } else {
      // We don't have previous data.
      print("No data found for key \(key), generating default values")
      settingsBundle = .default
      onboardingBundle = .default
    }
  }
}

extension UserDefaultsStorage : Storage {
  
  func save() throws {
    let migrationData = MigrationData(modelVersion: modelVersion,
                                      settingsBundle: settingsBundle,
                                      onboardingBundle: onboardingBundle)
    let encodedMigrationData = try JSONEncoder().encode(migrationData)
    UserDefaults.standard.set(encodedMigrationData, forKey: key)
  }
  
}
