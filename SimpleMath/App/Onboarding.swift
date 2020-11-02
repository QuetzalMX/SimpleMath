//  SimpleMath
//  Copyright (c) Filip Lazov 2020
//  MIT license - see LICENSE file for more info

import Combine

final class Onboarding: ObservableObject {
  private let storage: Storage
  @Published private(set) var showSettingsHint: Bool

  init(withStorage storage: Storage) {
    self.storage = storage
    showSettingsHint = !storage.onboardingBundle.seenSettingsHint
  }

  func discardSettingsHint() {
    guard showSettingsHint else { return }
    showSettingsHint = false
    storage.onboardingBundle = OnboardingBundle(seenSettingsHint: !showSettingsHint)
    do {
      try storage.save()
    } catch {
      print("failed saving data :", error)
    }
  }
}
