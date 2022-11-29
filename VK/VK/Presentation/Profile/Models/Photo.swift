// Photo.swift
// Copyright © RoadMap. All rights reserved.

/// Фото
struct Photo: Decodable {
    var photoPaths: [PhotoPath]

    enum CodingKeys: String, CodingKey {
        case photoPaths = "sizes"
    }
}
