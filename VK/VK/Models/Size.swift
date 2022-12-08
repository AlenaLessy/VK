// Size.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Размер фотографии в ленте
struct Size: Decodable {
    /// Путь фотографии
    let path: String

    enum CodingKeys: String, CodingKey {
        case path = "url"
    }
}
