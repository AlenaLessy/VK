// DataProvider.swift
// Copyright © RoadMap. All rights reserved.
// swiftlint: disable all

import Foundation
import RealmSwift

/// Выбор получения данных
final class DataProvider {
    // MARK: Private Properties

    private let networkService = NetworkService()
    private let realmService = RealmService()
    private var friendsToken: NotificationToken?
    private var groupsToken: NotificationToken?

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

    func observeGroups(handler: @escaping ([Group]) -> ()) {
        let results = realmService.fetch(Group.self)
        guard let results else { return }
        groupsToken = results.observe { change in
            switch change {
            case .update, .initial:
                handler(Array(results))
            default:
                break
            }
        }
    }

    func fetchPhotos(id: Int, handler: @escaping (Result<[Photo], NetworkError>) -> ()) {
        if let realmResults = realmService.fetch(Photo.self),
           realmResults.contains(where: { $0.ownerId == id })
        {
            let results = Array(realmResults).filter { $0.ownerId == id }
            handler(.success(results))
        } else {
            networkService.fetchAllPhotos(userId: id) { [weak self] result in
                switch result {
                case let .success(response):
                    handler(.success(response.items))
                    self?.realmService.save(items: response.items)
                case let .failure(error):
                    handler(.failure(error))
                }
            }
        }
    }

    func fetchGroups(handler: @escaping (Result<[Group], NetworkError>) -> ()) {
        networkService.fetchGroups { [weak self] result in
            switch result {
            case let .success(response):
                handler(.success(response.items))
                self?.realmService.save(items: response.items)
            case let .failure(error):
                handler(.failure(error))
            }
        }
    }

    func fetchFriends(handler: @escaping (Result<[Friend], NetworkError>) -> ()) {
        networkService.fetchFriends { [weak self] result in
            switch result {
            case let .success(response):
                handler(.success(response.items))
                self?.realmService.save(items: response.items)
            case let .failure(error):
                handler(.failure(error))
            }
        }
    }

    func fetchSearchGroups(searchingGroups: String, handler: @escaping (Result<[Group], NetworkError>) -> ()) {
        if let realmResults = realmService.fetch(Group.self),
           realmResults.contains(where: { $0.name == searchingGroups })
        {
            let results = Array(realmResults).filter { $0.name == searchingGroups }
            handler(.success(results))
        } else {
            networkService.fetchSearchGroups(searchingGroups: searchingGroups) { [weak self] result in
                switch result {
                case let .success(response):
                    handler(.success(response.items))
                    self?.realmService.save(items: response.items)
                case let .failure(error):
                    handler(.failure(error))
                }
            }
        }
    }
}
