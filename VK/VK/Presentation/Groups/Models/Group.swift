// Group.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Группы
final class Group: Object, Decodable {
    @objc dynamic var name: String
    @objc dynamic var photo: String

    enum CodingKeys: String, CodingKey {
        case photo = "photo_100"
        case name
    }
}
