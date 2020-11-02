//  SimpleMath
//  Copyright (c) Filip Lazov 2020
//  MIT license - see LICENSE file for more info

import Combine

final class StoredSettings: Settings {
  private var publishSettings: CurrentValueSubject<SettingsBundle, Never>
  private var storage: Storage

  var currentSettings: AnyPublisher<SettingsBundle, Never> {
    publishSettings.eraseToAnyPublisher()
  }

  init(withStorage storage: Storage) {
    self.storage = storage
    let settingsBundle = storage.settingsBundle
    publishSettings = .init(settingsBundle)
  }

  func updateSettings(bundle: SettingsBundle) {
    guard bundle != publishSettings.value else { return }
    
    do {
      storage.settingsBundle = bundle
      try storage.save()
    } catch {
      print("failed saving data :", error)
    }
    
    publishSettings.value = bundle
    
  }
}
