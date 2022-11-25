// VKItemResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Элементы ответа ВК
struct VKItemResponse: Decodable {
    var items: [Friend]
}

///// Элементы ответа ВК
// struct VKItemResponse<T>: Decodable where T: Decodable {
//    let items: [T]
// }
