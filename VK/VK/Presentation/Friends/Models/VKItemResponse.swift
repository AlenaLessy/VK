// VKItemResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Элементы ответа ВК
struct VKItemResponse: Decodable {
    var friends: [Friend]

    enum CodingKeys: String, CodingKey {
        case friends = "items"
    }
}
