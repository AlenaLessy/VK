// PhotoPath.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Путь к фото
final class PhotoPath: Object, Decodable {
    /// URL фотографии
    @objc dynamic var url: String
}
