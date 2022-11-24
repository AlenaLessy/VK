// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сетевые запросы
final class NetworkService: LoadDataServiceViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let recommendationsText = "/recommendations"
        static let queryItemTokenName = "access_token"
        static let queryItemfieldsName = "fields"
        static let queryItemVName = "v"
        static let queryItemLandName = "land"
        static let queryItemExtendedName = "extended"
        static let queryItemQName = "q"
        static let queryItemOwnerId = "owner_id"
        static let queryItemLandValue = "ru"
        static let queryItemVersionValue = "5.131"
        static let queryItemExtendedValue = "1"
        static let queryItemfieldsValue = "nickname"
        static let queryItemQValue = "Bears"
    }

    // MARK: - Private Properties

    private let friendsQueryItem = [
        URLQueryItem(name: Constants.queryItemTokenName, value: "\(Session.shared.token)"),
        URLQueryItem(name: Constants.queryItemfieldsName, value: Constants.queryItemfieldsValue),
        URLQueryItem(name: Constants.queryItemVName, value: Constants.queryItemVersionValue),
        URLQueryItem(name: Constants.queryItemLandName, value: Constants.queryItemLandValue)
    ]

    private let allPhotosQueryItem = [
        URLQueryItem(name: Constants.queryItemTokenName, value: "\(Session.shared.token)"),
        URLQueryItem(name: Constants.queryItemExtendedName, value: Constants.queryItemExtendedValue),
        URLQueryItem(name: Constants.queryItemOwnerId, value: "-\(Session.shared.userId)"),
        URLQueryItem(name: Constants.queryItemVName, value: Constants.queryItemVersionValue),
        URLQueryItem(name: Constants.queryItemLandName, value: Constants.queryItemLandValue),
    ]

    private let groupsQueryItem = [
        URLQueryItem(name: Constants.queryItemTokenName, value: "\(Session.shared.token)"),
        URLQueryItem(name: Constants.queryItemExtendedName, value: Constants.queryItemExtendedValue),
        URLQueryItem(name: Constants.queryItemVName, value: Constants.queryItemVersionValue),
        URLQueryItem(name: Constants.queryItemLandName, value: Constants.queryItemLandValue)
    ]

    private let searchGroupsQueryItem = [
        URLQueryItem(name: Constants.queryItemTokenName, value: "\(Session.shared.token)"),
        URLQueryItem(name: Constants.queryItemQName, value: Constants.queryItemQValue),
        URLQueryItem(name: Constants.queryItemVName, value: Constants.queryItemVersionValue),
        URLQueryItem(name: Constants.queryItemLandName, value: Constants.queryItemLandValue)
    ]

    // MARK: - Public Methods

    func fetchFriends() {
        loadData(componentsPath: .getFriends, queryItems: friendsQueryItem)
    }

    func fetchAllPhotos() {
        loadData(componentsPath: .getAllPhotos, queryItems: allPhotosQueryItem)
    }

    func fetchGroups() {
        loadData(componentsPath: .getGroups, queryItems: groupsQueryItem)
    }

    func fetchSearchGroups() {
        loadData(componentsPath: .searchGroups, queryItems: searchGroupsQueryItem)
    }
}
