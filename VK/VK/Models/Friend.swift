// Friend.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Друзья
final class Friend: Object, Decodable {
    @Persisted(primaryKey: true) var id = 0
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var imageName: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case imageName = "photo_100"
        case id
    }
}
