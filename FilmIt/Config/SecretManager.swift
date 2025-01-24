//
//  SecretManager.swift
//  FlimIt
//
//  Created by 한수빈 on 1/24/25.
//

import Foundation

enum SecretManager {
    static var accessToken: String {
        guard let token = Bundle.main.object(forInfoDictionaryKey: "ACCESS_TOKEN") as? String else {
            return ""
        }
        return token
    }
}
