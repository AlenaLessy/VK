// SaveToRealmGroupOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Операция по  сохранению данных в рилм
final class SaveToRealmOperation<T: Object & Decodable>: Operation {
    // MARK: - Public Properties

    var realmService = RealmService()

    // MARK: - Private Methods

    override func main() {
        guard let parseDataOperation = dependencies.first as? ParseDataOperation<T> else { return }
        realmService.save(items: parseDataOperation.items)
    }
}
