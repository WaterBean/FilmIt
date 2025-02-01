//
//  SearchResponse.swift
//  FilmIt
//
//  Created by 한수빈 on 1/30/25.
//

import Foundation

struct SearchResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    
}
