// ItemNewsResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Элементы ответа на новости ВК
struct ItemsNewsResponse: Decodable {
    let postNews: [NewsPost]
    let profilesInfo: [Friend]
    let groupsInfo: [Group]

    enum CodingKeys: String, CodingKey {
        case postNews = "items"
        case profilesInfo = "profiles"
        case groupsInfo = "groups"
    }

//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        postNews = try container.decode([NewsPost].self, forKey: .postNews)
//        profilesInfo = try container.decode([Friend].self, forKey: .profilesInfo)
//        groupsInfo = try container.decode([Group].self, forKey: .groupsInfo)
//    }
}
