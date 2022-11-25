// VKResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура ответа ВК
struct VKResponse: Decodable {
    var response: VKItemResponse
}

///// Структура ответа ВК
// struct VKResponse<T>: Decodable where T: Decodable {
//    let items: VKItemResponse<Friend>
// }
