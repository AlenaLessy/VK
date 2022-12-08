// NewsPhoto.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Фото в новости в ленте
struct NewsPhoto: Decodable {
    /// URL  - path фотографии
    let url: String?

    enum CodingKeys: CodingKey {
        case sizes
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let sizes = try container.decode([Size].self, forKey: .sizes)
        url = sizes.last?.path
    }
}
