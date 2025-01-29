//
//  UserStatusManager.swift
//  FlimIt
//
//  Created by 한수빈 on 1/24/25.
//

import UIKit


final class UserStatusManager {
    
    private init () { }
    
    enum UserStatus: Codable {
        case login
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
    
    static var status: UserStatus {
        get {
            guard let statusData = UserDefaults.standard.data(forKey: "userStatus"),
                  let status = try? JSONDecoder().decode(UserStatus.self, from: statusData) else { return .logout }
            return status
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "userStatus")
            }
            if newValue == .logout {
                profile = UIImage()
                nickname = ""
                removeAllSearchTerms()
            }
        }
    }
    
    static var profile: UIImage {
        get {
            guard let imageData = UserDefaults.standard.data(forKey: "profile"),
                  let image = UIImage(data: imageData) else { return UIImage() }
            return image
        }
        set {
            let imageData = newValue.jpegData(compressionQuality: 1.0)
            UserDefaults.standard.set(imageData, forKey: "profile")
        }
    }
    
    static var nickname: String {
        get {
            UserDefaults.standard.string(forKey: "nickname") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "nickname")
        }
    }
    
    private(set) static var searchTerms: [String: Date] {
        get {
            guard let terms = (UserDefaults.standard.dictionary(forKey: "searchTerms") ?? [:]) as? [String: Date] else { return [:] }
            return terms
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "searchTerms")
        }
    }
    
    static func addSearchTerms(keyword: String) {
        var terms = Self.searchTerms
        terms.updateValue(Date.now, forKey: keyword)
        Self.searchTerms = terms
    }
    
    static func removeSearchTerms(keyword: String) {
        var terms = Self.searchTerms
        terms.removeValue(forKey: keyword)
        Self.searchTerms = terms
    }
 
    static func removeAllSearchTerms() {
        Self.searchTerms = [:]
    }
    
}
