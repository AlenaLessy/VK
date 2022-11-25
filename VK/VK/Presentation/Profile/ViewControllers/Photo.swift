// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Друзья
struct Photo: Decodable {
    var photo: [PhotoPath]

    enum CodingKeys: String, CodingKey {
        case photo = "sizes"
    }
}
