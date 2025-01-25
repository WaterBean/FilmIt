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
            case .login: ViewController()
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
        }
    }
}
