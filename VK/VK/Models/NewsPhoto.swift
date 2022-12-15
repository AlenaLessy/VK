// NewsPhoto.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Фото в новости в ленте
struct NewsPhoto: Decodable {
    /// URL  - path фотографии
    let url: String?
    /// Высота фотографии
    let height: Int?
    /// Ширина фотографии
    let width: Int?

    /// Пропорции фотографии
    var aspectRation: CGFloat {
        guard let height,
              let width
        else { return 0 }
        return CGFloat(width) / CGFloat(height)
    }

    enum CodingKeys: CodingKey {
        case sizes
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let sizes = try container.decode([Size].self, forKey: .sizes)
        url = sizes.last?.path
        width = sizes.last?.width
        height = sizes.last?.height
    }
}
