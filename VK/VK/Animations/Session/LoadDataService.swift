// LoadDataService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Формирование запроса
class LoadDataService {
    // MARK: - Private Constants

    private enum Constants {
        static let getFriendsDescription = "/method/friends.get"
        static let getAllPhotosDescription = "/method/photos.getAll"
        static let getGroupsDescription = "/method/groups.get"
        static let searchGroupsDescription = "/method/groups.search"
        static let baseUrl = "https://api.vk.com/"
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

    // MARK: - Public Methods

    func loadData<T: Decodable>(
        componentsPath: NetworkServiceMethodKind,
        parameters: Parameters,
        handler: @escaping (Result<T, NetworkError>) -> ()
    ) {
        let baseURL = Constants.baseUrl
        let path = "\(componentsPath.description)"
        guard let url = URL(string: baseURL + path) else {
            handler(.failure(.urlFailure))
            return
        }
        AF.request(url, parameters: parameters).responseData { response in
            guard let data = response.data else { return }
            do {
                let vKResponse = try JSONDecoder().decode(T.self, from: data)
                handler(.success(vKResponse))
            } catch {
                handler(.failure(.decodingFailure))
            }
        }
    }
}
