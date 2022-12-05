// ItemsResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Элементы ответа ВК
struct ItemsResponse<T: Decodable>: Decodable {
    let items: [T]
}
