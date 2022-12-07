// NewsPost.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Новости
final class NewsPost: Decodable {
    /// Идентификатор пользователя
    let sourceId: Int
    /// Ссылка на фотографию группы
    let postType: String
    /// Идентификатор
    let post: String
    /// Вложения
    let attachments: [Attachments]

    var name: String?
    var photoUrl: String?

    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case postType = "post_type"
        case post = "text"
        case attachments
        case name
        case photoUrl
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sourceId = try container.decode(Int.self, forKey: .sourceId)
        postType = try container.decode(String.self, forKey: .postType)
        post = try container.decode(String.self, forKey: .post)
        attachments = (try container.decodeIfPresent([Attachments].self, forKey: .attachments)) ?? []
    }
}

///
struct Attachments: Decodable {
    let photo: NewsPhoto?

    enum CodingKeys: String, CodingKey {
        case photo
    }
}

///
struct NewsPhoto: Decodable {
    let url: String?

    enum CodingKeys: CodingKey {
        case sizes
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let sizes = try container.decode([Size].self, forKey: .sizes)
        url = sizes.last?.path
    }
}

///
struct Size: Decodable {
    let path: String

    enum CodingKeys: String, CodingKey {
        case path = "url"
    }
}
