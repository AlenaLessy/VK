// Session.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Данные о текущей сессии
final class Session {
    // MARK: - Public Properties

    static let shared = Session()

    var token = ""
    var userId = ""
    var clientId = 51_483_720

    // MARK: - Private Initializers

    private init() {}
}
