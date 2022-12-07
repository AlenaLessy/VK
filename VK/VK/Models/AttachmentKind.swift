// AttachmentKind.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Тип вложений
enum AttachmentKind: String, Decodable {
    case photo
    case video
    case audio
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try? container.decode(String.self)
        let kind = AttachmentKind(rawValue: string ?? "")
        self = kind ?? .unknown
    }
}
