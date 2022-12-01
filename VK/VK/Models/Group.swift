// Group.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Группы
final class Group: Object, Decodable {
    @Persisted var name: String
    @Persisted var photo: String
    @Persisted(primaryKey: true) var id = 0

    enum CodingKeys: String, CodingKey {
        case photo = "photo_100"
        case name
        case id
    }
}
