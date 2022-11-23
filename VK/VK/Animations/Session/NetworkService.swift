//
//  NetworkService.swift
//  VK
//
//  Created by Алена Панченко on 22.11.2022.
//

import UIKit

/// Сетевые запросы
final class NetworkService {
    // MARK: - Private Constants

    private enum Constants {
        static let recommendationsText = "/recommendations"
        static let uRLComponentsSchemeName = "https"
        static let uRLComponentsHostName = "api.vk.com"
        static let getFriendsDescription = "/method/friends.get"
        static let getAllPhotosDescription = "/method/photos.getAll"
        static let getGroupsDescription = "/method/groups.get"
        static let searchGroupsDescription = "/method/groups.search"
        static let queryItemTokenName = "access_token"
        static let queryItemfieldsName = "fields"
        static let queryItemVName = "v"
        static let queryItemLandName = "land"
        static let queryItemExtendedName = "extended"
        static let queryItemQName = "q"
        static let queryItemOwner_id = "owner_id"
        static let queryItemLandValue = "ru"
        static let queryItemVersionValue = "5.131"
        static let queryItemExtendedValue = "1"
        static let queryItemfieldsValue = "nickname"
        static let queryItemQValue = "Bears"
    }

    enum MethodKind: CustomStringConvertible {
        case getFriends
        case getAllPhotos
        case getGroups
        case searchGroups

        var description: String {
            switch self {
            case .getFriends:
                return Constants.getFriendsDescription
            case .getAllPhotos:
                return Constants.getAllPhotosDescription
            case .getGroups:
                return Constants.getGroupsDescription
            case .searchGroups:
                return Constants.searchGroupsDescription
            }
        }
    }

    // MARK: - Private Properties

    private let friendsQueryItem = [
        URLQueryItem(name: Constants.queryItemTokenName, value: "\(Settings.shared.token)"),
        URLQueryItem(name: Constants.queryItemfieldsName, value: Constants.queryItemfieldsValue),
        URLQueryItem(name: Constants.queryItemVName, value: Constants.queryItemVersionValue),
        URLQueryItem(name: Constants.queryItemLandName, value: Constants.queryItemLandValue)
    ]

    private let allPhotosQueryItem = [
        URLQueryItem(name: Constants.queryItemTokenName, value: "\(Settings.shared.token)"),
        URLQueryItem(name: Constants.queryItemExtendedName, value: Constants.queryItemExtendedValue),
        URLQueryItem(name: Constants.queryItemOwner_id, value: "-\(Settings.shared.userId)"),
        URLQueryItem(name: Constants.queryItemVName, value: Constants.queryItemVersionValue),
        URLQueryItem(name: Constants.queryItemLandName, value: Constants.queryItemLandValue),
    ]

    private let groupsQueryItem = [
        URLQueryItem(name: Constants.queryItemTokenName, value: "\(Settings.shared.token)"),
        URLQueryItem(name: Constants.queryItemExtendedName, value: Constants.queryItemExtendedValue),
        URLQueryItem(name: Constants.queryItemVName, value: Constants.queryItemVersionValue),
        URLQueryItem(name: Constants.queryItemLandName, value: Constants.queryItemLandValue)
    ]

    private let searchGroupsQueryItem = [
        URLQueryItem(name: Constants.queryItemTokenName, value: "\(Settings.shared.token)"),
        URLQueryItem(name: Constants.queryItemQName, value: Constants.queryItemQValue),
        URLQueryItem(name: Constants.queryItemVName, value: Constants.queryItemVersionValue),
        URLQueryItem(name: Constants.queryItemLandName, value: Constants.queryItemLandValue)
    ]

    // MARK: - Public Methods

    func getFriends() {
        getService(componentsPath: .getFriends, queryItems: friendsQueryItem)
    }

    func getAllPhotos() {
        getService(componentsPath: .getAllPhotos, queryItems: allPhotosQueryItem)
    }

    func getGroups() {
        getService(componentsPath: .getGroups, queryItems: groupsQueryItem)
    }

    func searchGroups() {
        getService(componentsPath: .searchGroups, queryItems: searchGroupsQueryItem)
    }

    // MARK: - Private Methods

    private func getService(componentsPath: MethodKind, queryItems: [URLQueryItem]) {
        var components = URLComponents()
        components.scheme = Constants.uRLComponentsSchemeName
        components.host = Constants.uRLComponentsHostName
        components.path = componentsPath.description
        components.queryItems = queryItems

        guard let url = components.url else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, _, _ in

            if let data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                print("TEST \(componentsPath) \(json ?? "")")
            }
        }
        task.resume()
    }
}
