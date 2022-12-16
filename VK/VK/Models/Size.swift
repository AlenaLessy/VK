// Size.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Размер фотографии в ленте
struct Size: Decodable {
    /// Путь фотографии
    let path: String
    /// Ширина фотографии
    let width: Int?
    /// Высота фотографии
    let height: Int?

    enum CodingKeys: String, CodingKey {
        case path = "url"
        case width
        case height
    }
}
