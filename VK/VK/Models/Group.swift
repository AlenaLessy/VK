// Group.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Группы
final class Group: Object, Decodable {
    /// Имя группы
    @Persisted var name: String
    /// Ссылка на фотографию группы
    @Persisted var photo: String
    /// Идентификатор
    @Persisted(primaryKey: true) var id = 0

    enum CodingKeys: String, CodingKey {
        case photo = "photo_100"
        case name
        case id
    }
}
