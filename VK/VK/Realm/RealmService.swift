// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

///
final class RealmService {
    func save(items: [Object]) {
        do {
            try realm?.write {
                realm?.add(items, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetch<T: Object>(
        _ type: T.Type
    ) -> Results<T>? {
        do {
            let realm = try? Realm()
            let objects = realm?.objects(type)
            return objects
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    var fileUrl: String? {
        realm?.configuration.fileURL?.absoluteString
    }

    private var realm: Realm? = try? Realm()
//    private var config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
}
