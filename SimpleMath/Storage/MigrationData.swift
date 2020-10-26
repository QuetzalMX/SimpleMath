//
//  MigrationData.swift
//  SimpleMath
//
//  Created by Fernando Olivares on 10/25/20.
//  Copyright © 2020 Filip Lazov. All rights reserved.
//

import Foundation

struct MigrationData: Codable {
  let modelVersion: String
  var settingsBundle: SettingsBundle
  var onboardingBundle: OnboardingBundle
}
