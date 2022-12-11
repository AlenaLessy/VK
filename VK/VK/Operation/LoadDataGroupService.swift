// LoadDataGroupService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire

/// Формирование запроса группы
final class LoadDataGroupService {
    // MARK: - Private Constants

    private enum Constants {
        static let getGroupsDescription = "/method/groups.get"
        static let searchGroupsDescription = "/method/groups.search"
        static let baseUrl = "https://api.vk.com/"
    }

    // MARK: - Types

    enum NetworkServiceGroupMethodKind: CustomStringConvertible {
        case getGroups
        case searchGroups

        var description: String {
            switch self {
            case .getGroups:
                return Constants.getGroupsDescription
            case .searchGroups:
                return Constants.searchGroupsDescription
            }
        }
    }

    // MARK: - Public Methods

    func loadGroupData<T: Decodable>(
        componentsPath: NetworkServiceGroupMethodKind,
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
                let response = try JSONDecoder().decode(Response<T>.self, from: data)

                handler(.success(response.response))
            } catch {
                handler(.failure(.decodingFailure))
            }
        }
    }
}
