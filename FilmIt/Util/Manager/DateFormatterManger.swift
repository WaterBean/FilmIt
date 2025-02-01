//
//  DateFormatterManger.swift
//  FilmIt
//
//  Created by 한수빈 on 2/1/25.
//

import Foundation


final class DateFormatterManager {
    
    static let shared = DateFormatterManager()
    private init() {
    }
    
    private let formatter = DateFormatter()
    
    func yyMMDD(_ date: Date) -> String {
        formatter.dateFormat = "yy.MM.dd"
        return formatter.string(from: date)
    }
    
    
}
