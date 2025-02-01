//
//  ImageResponse.swift
//  FilmIt
//
//  Created by 한수빈 on 1/31/25.
//

import Foundation

struct ImageResponse: Codable {
    let id: Int
    let backdrops: [FilePath]
    let posters: [FilePath]
}

struct FilePath: Codable {
    let filePath: String?
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
    
    
}
