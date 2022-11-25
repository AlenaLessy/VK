// PhotoItemResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Элементы ответа фото
struct PhotoItemResponse: Decodable {
    var photos: [Photo]

    enum CodingKeys: String, CodingKey {
        case photos = "items"
    }
}
