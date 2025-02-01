//
//  SecretManager.swift
//  FlimIt
//
//  Created by 한수빈 on 1/24/25.
//

import Foundation

enum SecretManager {
    
    static var accessToken: String {
        Bundle.main.object(forInfoDictionaryKey: "ACCESS_TOKEN") as? String ?? ""
    }
    
    static var baseURL: String {
        Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
    }

    static var imageURL: String {
        Bundle.main.object(forInfoDictionaryKey: "IMAGE_URL") as? String ?? ""
    }
    
    static var bigImageURL: String {
        Bundle.main.object(forInfoDictionaryKey: "BIG_IMAGE_URL") as? String ?? ""
    }
    
    
}
