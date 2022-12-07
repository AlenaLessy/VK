// ItemNewsResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Элементы ответа на новости ВК
struct ItemsNewsResponse: Decodable {
    /// Новостные посты
    var postNews: [NewsPost]
    /// Информация о друзьях
    let profilesInfo: [Friend]
    /// Информация о группах
    let groupsInfo: [Group]

    enum CodingKeys: String, CodingKey {
        case postNews = "items"
        case profilesInfo = "profiles"
        case groupsInfo = "groups"
    }
}
