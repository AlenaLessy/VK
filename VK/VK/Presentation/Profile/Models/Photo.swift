// Photo.swift
// Copyright © RoadMap. All rights reserved.

/// Фото
struct Photo: Decodable {
    var photoPath: [PhotoPath]

    enum CodingKeys: String, CodingKey {
        case photoPath = "sizes"
    }
}
