// Response.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ответ от ВК
struct Response<T: Decodable>: Decodable {
    let response: T
}
