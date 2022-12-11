// PromiseProvider.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import PromiseKit
import RealmSwift

/// Выбор получения данных друзей
final class PromiseProvider {
    // MARK: Private Properties

    private let networkService = NetworkService()
    private let realmService = RealmService()
    private let promiseService = PromiseService()
    private var friendsToken: NotificationToken?

    // MARK: - Public Methods

    func observeFriends(handler: @escaping ([Friend]) -> ()) {
        let results = realmService.fetch(Friend.self)
        guard let results else { return }
        friendsToken = results.observe { change in
            switch change {
            case .update, .initial:
                handler(Array(results))
            default:
                break
            }
        }
    }

    func fetchFriends() {
        firstly {
            promiseService.fetchFriends()
        }.done { friends in
            self.realmService.save(items: friends.response.items)
        }.catch { error in
            print(error.localizedDescription)
        }
    }
}
