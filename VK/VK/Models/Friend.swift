// Friend.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Друзья
final class Friend: Object, Decodable {
    /// Идентификатор друга
    @Persisted(primaryKey: true) var id = 0
    /// Имя друга
    @Persisted var firstName: String
    /// Фамилия друга
    @Persisted var lastName: String
    /// Ссылка на фотографию аватара друга
    @Persisted var imageName: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case imageName = "photo_100"
        case id
    }
}
