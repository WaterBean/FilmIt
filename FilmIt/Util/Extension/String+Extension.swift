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
    
    func toAttribute(_ target: String) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(.foregroundColor, value: UIColor.systemOrange, range: (self as NSString).range(of: target))
        return attributeString
    }
    
    
}

extension NSMutableAttributedString {
    func toAttribute(_ target: String) -> NSMutableAttributedString {
        self.addAttribute(.foregroundColor, value: UIColor.systemOrange, range: (string as NSString).range(of: target))
        return self
    }
}
