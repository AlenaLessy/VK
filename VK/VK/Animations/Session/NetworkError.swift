// NetworkError.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вид сетевых ошибок
enum NetworkError: Error {
    case unknown
    case decodingFailure
    case urlFailure
}
