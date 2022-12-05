// NewsFriends.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Новости друзей
struct FriendNews {
    /// Имя друга
    let name: String
    /// Имена фотографий друга
    let imageNames: [String]
    /// Возраст друга
    var age: Int?
    /// Город друга
    var city: String?
}
