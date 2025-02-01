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
    
    func yyMMdd(_ date: Date) -> String {
        formatter.dateFormat = "yy.MM.dd"
        return formatter.string(from: date)
    }
    
    func yyyyMMdd(_ date: String) -> String {
        formatter.dateFormat = "yyyy-MM-dd"
        let string = formatter.date(from: date)
        formatter.dateFormat = "yyyy. MM. dd"
        return formatter.string(from: string ?? Date())
    }
    
}
