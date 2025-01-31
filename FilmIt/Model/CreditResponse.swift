//
//  CreditResponse.swift
//  FilmIt
//
//  Created by 한수빈 on 1/31/25.
//

import Foundation

struct CreditResponse: Codable {
    
    let id: Int
    let cast: Cast
    
    
}

struct Cast: Codable {
    
    let name: String
    let character: String
    let profilePath: String
    
    enum CodingKeys: String, CodingKey {
        case name, character
        case profilePath = "profile_path"
    }
    
    
}
