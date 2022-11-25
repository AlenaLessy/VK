// GroupItemResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура ответа ВК на группы
struct GroupItemResponse: Decodable {
    var items: [Group]
}
