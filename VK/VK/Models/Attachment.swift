// Attachment.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вложение
struct Attachment: Decodable {
    /// Фотографии ленты
    let photo: NewsPhoto?
    /// Тип вложения
    let type: AttachmentKind

    enum CodingKeys: String, CodingKey {
        case photo
        case type
    }
}
