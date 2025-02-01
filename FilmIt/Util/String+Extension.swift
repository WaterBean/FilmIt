//
//  String+Extension.swift
//  FilmIt
//
//  Created by 한수빈 on 1/31/25.
//

import UIKit

extension String {
    
    func toImageURL() -> String {
        return SecretManager.imageURL + self
    }
    func toBigImageURL() -> String {
        return SecretManager.bigImageURL + self
    }
    
    
}
