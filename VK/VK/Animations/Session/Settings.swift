//
//  Settings.swift
//  VK
//
//  Created by Алена Панченко on 21.11.2022.
//

import UIKit

/// Хранение данных о текущей сессии
final class Settings {
    // MARK: - Public Properties

    static let shared = Settings()

    // MARK: - Public Properties

    var token = ""
    var userId = 25_628_573
    var clientId = 51_483_720

    // MARK: - Private Initializers

    private init() {}
}
