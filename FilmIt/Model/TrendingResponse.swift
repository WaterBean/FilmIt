//
//  TrendingResponse.swift
//  FilmIt
//
//  Created by 한수빈 on 1/30/25.
//

import Foundation

struct TrendingResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let backdropPath: String?
    let title: String
    let overview: String
    let posterPath: String?
    let genreIds: [Int]
    let releaseDate: String
    let voteAverage: Double
    var isLike : Bool {
        UserStatusManager.likeMovies.contains(id)
    }
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
}
