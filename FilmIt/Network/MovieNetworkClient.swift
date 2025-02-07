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
                                      router: any URLRequestConvertible,
                                      completion: @escaping (Result<T, AFError>) -> Void) {
        
        AF.request(router)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: decodable) { response in
                completion(response.result)
            }
    }
    
    
}

