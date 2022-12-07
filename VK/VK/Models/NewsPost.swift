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
    let attachments: [Attachment]
    /// Имя группы или друга
    var name: String?
    /// Имя аватара
    var photoUrlName: String?
    //    var postPhotos: [String?] = []

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
        attachments = (try container.decodeIfPresent([Attachment].self, forKey: .attachments)) ?? []
    }
}
