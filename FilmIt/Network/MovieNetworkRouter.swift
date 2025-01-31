//
//  MovieNetworkRouter.swift
//  FilmIt
//
//  Created by 한수빈 on 1/30/25.
//

import Foundation
import Alamofire

enum MovieNetworkRouter: URLRequestConvertible {
    
    case trending
    case search(query: String, page: Int)
    case image(id: Int)
    case credit(id: Int)
    
    var baseURL: URL {
        URL(string: SecretManager.baseURL)!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .trending:
            return "/trending/movie/day"
        case .search:
            return "/search/movie"
        case let .image(id: id):
            return "/movie/\(id)/images"
        case let .credit(id: id):
            return "/movie/\(id)/credits"
        }
    }
    
    var headers: HTTPHeaders {
        ["Authorization": "Bearer \(SecretManager.accessToken)"]
    }
    
    var parameters: Parameters? {
        switch self {
        case .trending:
            ["language": "ko-KR", "page": 1]
        case let .search(query: query, page: page):
            ["query": query, "include_adult": "false", "language": "ko-KR", "page": page]
        case .image:
            nil
        case .credit:
            ["language": "ko-KR"]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .trending:
            return URLEncoding.queryString
        default:
            return URLEncoding.queryString
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        
        urlRequest.method = method
        
//        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.headers = headers
        
        if let parameters = parameters {
            return try encoding.encode(urlRequest, with: parameters)
        }
                
        return urlRequest

    }
    
    
}
