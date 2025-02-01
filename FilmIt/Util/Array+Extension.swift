//
//  Array+Extension.swift
//  FilmIt
//
//  Created by 한수빈 on 2/1/25.
//

import Foundation

extension Array {
    
    subscript (safe index: Int) -> Element? {
        return startIndex <= index && index < endIndex ? self[index] : nil
    }
    
    
}
