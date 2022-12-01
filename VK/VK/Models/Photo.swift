// Photo.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
/// Фото
final class Photo: Object, Decodable {
    @Persisted(primaryKey: true) var id = 0
    @Persisted var photoPaths: List<PhotoPath>
    @Persisted var ownerId: Int

    enum CodingKeys: String, CodingKey {
        case photoPaths = "sizes"
        case ownerId = "owner_id"
        case id
    }
}
