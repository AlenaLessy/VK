// Photo.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Фото
final class Photo: Object, Decodable {
    /// Идентификатор
    @Persisted(primaryKey: true) var id = 0
    /// Массив ссылок на фотографии друга
    @Persisted var photoPaths: List<PhotoPath>
    /// идентификатор друга
    @Persisted var ownerId: Int

    enum CodingKeys: String, CodingKey {
        case photoPaths = "sizes"
        case ownerId = "owner_id"
        case id
    }
}
