//
//  UserStatusManager.swift
//  FlimIt
//
//  Created by 한수빈 on 1/24/25.
//

import UIKit

final class UserStatusManager {
    
    private init() { }
    
    enum UserStatus: Codable, Comparable {
        case login(date: Date)
        case logout
        
        func replaceScene() -> Void {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            let rootVC = switch self {
            case .login: TabBarViewController()
            case .logout: UINavigationController(rootViewController: OnboardingViewController())
            }
            window.rootViewController = rootVC
            window.makeKeyAndVisible()
        }
    }
    
    private enum UserDefaultsKey {
        static let status = "userStatus"
        static let profile = "profile"
        static let nickname = "nickname"
        static let likeMovies = "likeMovies"
        static let searchTerms = "searchTerms"
    }
    
    static var status: UserStatus {
        get {
            guard let statusData = UserDefaults.standard.data(forKey: UserDefaultsKey.status),
                  let status = try? JSONDecoder().decode(UserStatus.self, from: statusData) else {
                return .logout
            }
            return status
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: UserDefaultsKey.status)
            }
            if newValue == .logout {
                clearUserData()
            }
        }
    }
    
    static var profile: String {
        get {
            UserDefaults.standard.string(forKey: UserDefaultsKey.profile) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.profile)
            notifyStatusChange()
        }
    }
    
    static var nickname: String {
        get {
            UserDefaults.standard.string(forKey: UserDefaultsKey.nickname) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.nickname)
            notifyStatusChange()
        }
    }
    
    private(set) static var likeMovies: Set<Int> {
        get {
            guard let movies = UserDefaults.standard.array(forKey: UserDefaultsKey.likeMovies) as? [Int] else {
                return Set<Int>()
            }
            return Set(movies)
        }
        set {
            UserDefaults.standard.set(Array(newValue), forKey: UserDefaultsKey.likeMovies)
            notifyStatusChange()
        }
    }
    
    static func addLike(movieId: Int) {
        var movies = likeMovies
        movies.insert(movieId)
        likeMovies = movies
        print(likeMovies)
    }
    
    static func removeLike(movieId: Int) {
        var movies = likeMovies
        movies.remove(movieId)
        likeMovies = movies
        print(likeMovies)
    }
    
    static func removeAllLikes() {
        likeMovies = Set<Int>()
    }
    
    static func isLiked(movieId: Int) -> Bool {
        likeMovies.contains(movieId)
    }
    
    private(set) static var searchTerms: [String: Date] {
        get {
            UserDefaults.standard.dictionary(forKey: UserDefaultsKey.searchTerms) as? [String: Date] ?? [:]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.searchTerms)
        }
    }
    
    static func addSearchTerm(keyword: String) {
        var terms = searchTerms
        terms[keyword] = Date.now
        searchTerms = terms
    }
    
    static func removeSearchTerm(keyword: String) {
        var terms = searchTerms
        terms.removeValue(forKey: keyword)
        searchTerms = terms
    }

    static func removeAllSearchTerms() {
        searchTerms = [:]
    }
    
    private static func notifyStatusChange() {
        NotificationCenter.default.post(name: .userStatus, object: nil, userInfo: [
            "profile": profile,
            "nickname": nickname,
            "likeCount": likeMovies.count
        ]
        )
    }
    
    private static func clearUserData() {
        profile = ""
        nickname = ""
        removeAllLikes()
        removeAllSearchTerms()
    }
    
    
}
