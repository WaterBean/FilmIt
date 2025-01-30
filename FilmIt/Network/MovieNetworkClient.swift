//
//  MovieNetworkClient.swift
//  FilmIt
//
//  Created by 한수빈 on 1/30/25.
//

import Foundation
import Alamofire


final class MovieNetworkClient {
    private init () {}
    static func request<T: Decodable>(_ decodable: T.Type,
                                      router: MovieNetworkRouter,
                                      success: @escaping (T)-> Void,
                                      failure: @escaping (_ error: NetworkError) -> Void) {
        
        AF.request(router)
            .validate(statusCode: 200..<300)
//            .responseString(completionHandler: {
//                print($0)
//            })
            .responseDecodable(of: decodable) { response in
                switch response.result {
                case .success(let result):
                    success(result)
                case .failure(let error):
                    let statusCode = response.response?.statusCode ?? -1
                    let networkError: NetworkError

                    switch statusCode {
                        case 300..<400: networkError = .redirection(statusCode)
                        case 400: networkError = .badRequest
                        case 401: networkError = .unauthorized
                        case 403: networkError = .forbidden
                        case 404: networkError = .notFound
                        case 500...: networkError = .serverError(statusCode)
                        case -1: networkError = .noConnection
                        default: networkError = .unknown(error)
                    }
                    failure(networkError)
                }
            }
    }
    
    
}


enum NetworkError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case redirection(Int)
    case serverError(Int)
    case noConnection
    case unknown(Error)
    
    var message: String {
        switch self {
            case .badRequest: return "잘못된 요청입니다"
            case .unauthorized: return "인증이 필요합니다"
            case .forbidden: return "접근이 거부되었습니다"
            case .notFound: return "리소스를 찾을 수 없습니다"
            case .redirection: return "리다이렉션이 발생했습니다"
            case .serverError: return "서버 에러가 발생했습니다"
            case .noConnection: return "네트워크 연결을 확인해주세요"
            case .unknown: return "알 수 없는 에러가 발생했습니다"
        }
    }
}
