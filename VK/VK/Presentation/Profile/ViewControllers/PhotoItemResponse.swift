// PhotoItemResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура ответа ВК
struct PhotoItemResponse: Decodable {
    var items: [Photo]
}
