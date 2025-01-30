//
//  TrendingResponse.swift
//  FilmIt
//
//  Created by 한수빈 on 1/30/25.
//

import Foundation

struct TrendingResponse: Codable {
    let results: [Trending]
}

struct Trending: Codable {
    let id: Int
    let backdropPath: String
    let title: String
    let overview: String
    let posterPath: String
    let genreIds: [Int]
    let releaseDate: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
}
