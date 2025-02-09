//
//  Observable.swift
//  FilmIt
//
//  Created by 한수빈 on 2/9/25.
//

final class Observable<T> {
    
    private var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        self.closure = closure
    }
    
    func lazyBind(_ closure: @escaping (T) -> Void) {
        self.closure = closure
    }
    
    
}

