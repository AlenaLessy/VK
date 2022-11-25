// Friend.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Друзья
final class Friend: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var firstName: String
    @objc dynamic var lastName: String
    @objc dynamic var imageName: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case imageName = "photo_100"
        case id
    }
}
