// PhotoPath.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Путь к фото
final class PhotoPath: Object, Decodable {
    @objc dynamic var url: String
}
