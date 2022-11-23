//
//  Settings.swift
//  VK
//
//  Created by Алена Панченко on 21.11.2022.
//

import UIKit

/// Хранение данных о текущей сессии
final class Session {
    // MARK: - Public Properties

    static let shared = Session()

    var token = ""
    var userId = ""
    var clientId = 51_483_720

    // MARK: - Private Initializers

    private init() {}
}
