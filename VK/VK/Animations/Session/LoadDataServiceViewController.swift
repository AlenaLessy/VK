// LoadDataServiceViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Формирование запроса
class LoadDataServiceViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let getFriendsDescription = "/method/friends.get"
        static let getAllPhotosDescription = "/method/photos.getAll"
        static let getGroupsDescription = "/method/groups.get"
        static let searchGroupsDescription = "/method/groups.search"
        static let uRLComponentsSchemeName = "https"
        static let uRLComponentsHostName = "api.vk.com"
    }

    // MARK: - Types

    enum NetworkServiceMethodKind: CustomStringConvertible {
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

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Public Methods

    func loadData(componentsPath: NetworkServiceMethodKind, queryItems: [URLQueryItem]) {
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
