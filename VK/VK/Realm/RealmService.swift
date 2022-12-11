// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Сохранение и получение данных из рилма
final class RealmService {
    // MARK: - Private Properties

    private var realm: Realm? = try? Realm()

    // MARK: - Public Methods

    func save(items: [Object]) {
        DispatchQueue.main.async {
            do {
                try self.realm?.write {
                    self.realm?.add(items, update: .modified)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func fetch<T: Object>(
        _ type: T.Type
    ) -> Results<T>? {
        let objects = realm?.objects(type)
        return objects
    }
}
