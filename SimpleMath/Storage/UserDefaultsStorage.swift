//  SimpleMath
//  Copyright (c) Filip Lazov 2020
//  MIT license - see LICENSE file for more info

import Foundation

final class UserDefaultsStorage: Storage {
  
  let modelVersion: String
  let key: String

  private var migrationData: MigrationData
  
  init(withKey: String, modelVersion: String, migrationData: MigrationData) {
    key = withKey
    self.modelVersion = modelVersion
    self.migrationData = migrationData
  }
}

// MARK: - Settings
extension UserDefaultsStorage {
  
  func store(settingsBundle: SettingsBundle) {
    migrationData.settingsBundle = settingsBundle
    save(storedData: migrationData)
  }

  func loadSettingsBundle() -> SettingsBundle {
    return migrationData.settingsBundle
  }
}

// MARK: - Onboarding
extension UserDefaultsStorage {
  
  func store(onboardingBundle: OnboardingBundle) {
    migrationData.onboardingBundle = onboardingBundle
    save(storedData: migrationData)
  }

  func loadOnboardingBundle() -> OnboardingBundle {
    return migrationData.onboardingBundle
  }
}

extension UserDefaultsStorage {
  
  #warning("Can we make this function throw?")
  private func save(storedData: MigrationData) {
    do {
      try UserDefaults.standard.set(JSONEncoder().encode(migrationData), forKey: key)
    } catch {
      print("failed saving data :", error)
    }
  }
}
