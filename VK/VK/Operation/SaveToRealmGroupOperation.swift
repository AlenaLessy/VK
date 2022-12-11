// SaveToRealmGroupOperation.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Операция по  сохранению данных в рилм
final class SaveToRealmOperation<T: Object & Decodable>: Operation {
    // MARK: - Public Properties

    var realmService = RealmService()

    // MARK: - Public Methods

    override func main() {
        guard let parseDataOperation = dependencies.first as? ParseDataOperation<T> else { return }
        realmService.save(items: parseDataOperation.items)
    }
}
