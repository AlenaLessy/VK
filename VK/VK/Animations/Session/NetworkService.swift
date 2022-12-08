// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Сетевые запросы
final class NetworkService: LoadDataService {
    // MARK: - Private Constants

    private enum Constants {
        static let recommendationsText = "/recommendations"
        static let parameterTokenName = "access_token"
        static let parameterfieldsName = "fields"
        static let parameterVName = "v"
        static let parameterLandName = "land"
        static let parameterExtendedName = "extended"
        static let parameterQName = "q"
        static let parameterOwnerId = "owner_id"
        static let parameterLandValue = "ru"
        static let parameterVersionValue = "5.131"
        static let parameterExtendedValue = "1"
        static let parameterfieldsValue = "photo_100"
        static let parameterQValue = "Bears"
        static let parameterOrderValue = "order"
        static let parameterOrderName = "name"
        static let parameterFiltersValue = "post"
        static let parameterFiltersName = "filters"
    }

    // MARK: - Private Properties

    private let friendsParameters: Parameters = [
        Constants.parameterTokenName: "\(Session.shared.token)",
        Constants.parameterfieldsName: Constants.parameterfieldsValue,
        Constants.parameterVName: Constants.parameterVersionValue,
        Constants.parameterLandName: Constants.parameterLandValue,
        Constants.parameterOrderName: Constants.parameterOrderValue
    ]

    private let allPhotosParameters: Parameters = [
        Constants.parameterTokenName: "\(Session.shared.token)",
        Constants.parameterExtendedName: Constants.parameterExtendedValue,
        Constants.parameterOwnerId: "-\(Session.shared.userId)",
        Constants.parameterVName: Constants.parameterVersionValue,
        Constants.parameterLandName: Constants.parameterLandValue,
    ]

    private let groupsParameters: Parameters = [
        Constants.parameterTokenName: "\(Session.shared.token)",
        Constants.parameterExtendedName: Constants.parameterExtendedValue,
        Constants.parameterVName: Constants.parameterVersionValue,
        Constants.parameterLandName: Constants.parameterLandValue
    ]

    private let newsPostParameters: Parameters = [
        Constants.parameterTokenName: "\(Session.shared.token)",
        Constants.parameterFiltersName: Constants.parameterFiltersValue,
        Constants.parameterVName: Constants.parameterVersionValue,
    ]

    // MARK: - Public Methods

    func fetchFriends(handler: @escaping (Result<ItemsResponse<Friend>, NetworkError>) -> ()) {
        loadData(componentsPath: .getFriends, parameters: friendsParameters, handler: handler)
    }

    func fetchAllPhotos(userId: Int, handler: @escaping (Result<ItemsResponse<Photo>, NetworkError>) -> ()) {
        loadData(componentsPath: .getAllPhotos, parameters: [
            Constants.parameterTokenName: "\(Session.shared.token)",
            Constants.parameterExtendedName: Constants.parameterExtendedValue,
            Constants.parameterOwnerId: "\(userId)",
            Constants.parameterVName: Constants.parameterVersionValue
        ], handler: handler)
    }

    func fetchGroups(handler: @escaping (Result<ItemsResponse<Group>, NetworkError>) -> ()) {
        loadData(componentsPath: .getGroups, parameters: groupsParameters, handler: handler)
    }

    func fetchSearchGroups(
        searchingGroups: String,
        handler: @escaping (Result<ItemsResponse<Group>, NetworkError>) -> ()
    ) {
        loadData(
            componentsPath: .searchGroups,
            parameters: [
                Constants.parameterTokenName: "\(Session.shared.token)",
                Constants.parameterQName: searchingGroups,
                Constants.parameterVName: Constants.parameterVersionValue,
                Constants.parameterLandName: Constants.parameterLandValue
            ],
            handler: handler
        )
    }

    func fetchFotoData(_ url: URL, handler: @escaping (Data) -> ()) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                guard let data
                else { return }
                handler(data)
            }
        }.resume()
    }

    func fetchNewsPost(
        handler: @escaping (Result<ItemsNewsResponse, NetworkError>) -> ()
    ) {
        loadData(
            componentsPath: .getNewsFeed,
            parameters: newsPostParameters,
            handler: handler
        )
    }
}
