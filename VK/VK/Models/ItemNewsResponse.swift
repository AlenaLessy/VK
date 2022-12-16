// ItemNewsResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Элементы ответа на новости ВК
struct ItemsNewsResponse: Decodable {
    /// Информация о друзьях
    let friends: [Friend]
    /// Информация о группах
    let groups: [Group]
    /// Cледующая страница
    let nextPage: String?
    /// Новостные посты
    var newsPost: [NewsPost]

    enum CodingKeys: String, CodingKey {
        case newsPost = "items"
        case friends = "profiles"
        case groups
        case nextPage = "next_from"
    }
}
