//
//  ProfileContainerViewModel.swift
//  FilmIt
//
//  Created by 한수빈 on 2/11/25.
//

import Foundation

final class ProfileContainerViewModel: BaseViewModel {
    
    struct Input {
        let initialLoad: Observable<Void> = Observable(())
        let tapped: Observable<Void> = Observable(())
    }
    
    struct Output {
        let profile: Observable<String> = Observable("")
        let joinDate: Observable<String?> = Observable(nil)
        let nickname: Observable<String?> = Observable(nil)
        let likeMovieCountText: Observable<AttributedString?> = Observable(nil)
        let presentProfileSetting: Observable<Void> = Observable(())
        
    }
    private(set) var input = Input()
    private(set) var output = Output()
    
    init() {
        print(#function)
        transform()
    }
    
    func transform() {
        input.initialLoad.bind { [weak self] _ in
            self?.initialLoad()
        }
        
        input.tapped.lazyBind { [weak self] _ in
            self?.output.presentProfileSetting.value = ()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotification), name: .userStatus , object: nil)
        
    }
    
    private func initialLoad() {
        output.joinDate.value = loadJoinDate()
        output.nickname.value = loadNickName()
        output.likeMovieCountText.value = loadLikeMovieCountText()
        output.profile.value = loadProfile()
    }
    
    private func loadJoinDate() -> String {
        if case .login(let date) = UserStatusManager.status {
            return DateFormatterManager.shared.yyMMdd(date) + " 가입"
        } else {
            return DateFormatterManager.shared.yyMMdd(Date.now) + " 가입"
        }
    }
    
    private func loadNickName() -> String {
        return UserStatusManager.nickname
    }
    
    private func loadLikeMovieCountText() -> AttributedString {
        return "\(UserStatusManager.likeMovies.count) 개의 무비박스 보관중".toWhiteBoldAttributedString()

    }
    
    private func loadProfile() -> String {
        return UserStatusManager.profile
    }
    
    @objc private func receiveNotification(value: NSNotification) {
        print("신호 수신" + #function + String(describing: self))
        if let profile = value.userInfo?["profile"] as? String,
           let nickname = value.userInfo?["nickname"] as? String,
           let likeCount = value.userInfo?["likeCount"] as? Int {
            output.profile.value = profile
            output.nickname.value = nickname
            output.likeMovieCountText.value = "\(likeCount) 개의 무비박스 보관중".toWhiteBoldAttributedString()
        } else {
            print("제대로 값을 받지 못함")
        }
    }
    
    
}
