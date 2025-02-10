//
//  ProfileNicknameSettingViewModel.swift
//  FilmIt
//
//  Created by 한수빈 on 2/9/25.
//

import Foundation

final class ProfileNicknameSettingViewModel: BaseViewModel {
    
    struct Input {
        let whenViewDidLoad: Observable<Bool> = Observable(false)
        let profileTapped: Observable<Void> = Observable(())
        let nicknameText: Observable<String?> = Observable(nil)
        let mbtiTapped: Observable<String?> = Observable(nil)
        let completeTapped: Observable<Void> = Observable(())
    }
    
    struct Output {
        let statusLabelText: Observable<String?> = Observable(nil)
        let statusLabelStatus = Observable(false)
        let profile: Observable<String> = Observable(UserStatusManager.profile)
        let profileTapped: Observable<String> = Observable("")
        let mbti: Observable<[String]> = Observable(["","","",""])
        let completeTapped: Observable<Void> = Observable(())
        let isValid: Observable<Bool> = Observable(false)
    }
    
    func transform() {
        input.whenViewDidLoad.bind { [weak self] inNickname in
            switch UserStatusManager.status {
            case .logout:
                self?.setRandomImage()
            case .login:
                self?.input.nicknameText.value = UserStatusManager.profile
                self?.input.nicknameText.value = UserStatusManager.nickname
                self?.validateUserInput(text: UserStatusManager.nickname)
            }
        }
        
        input.nicknameText.bind { [weak self] text in
            self?.validateUserInput(text: text)
        }
        
        input.profileTapped.lazyBind { [weak self] in
            guard let self else { return }
            self.output.profileTapped.value = self.output.profile.value
        }
        
        input.mbtiTapped.lazyBind { [weak self] string in
            self?.mbtiButtonTapped(selected: string)
        }
        
        input.completeTapped.lazyBind { [weak self] in
            self?.saveUserData()
        }

    }

    private(set) var input = Input()
    private(set) var output = Output()
    private var isMbtiFilled = false
    
    init() {        
        transform()
    }
    
    private func saveUserData() {
        guard let nickname = input.nicknameText.value else { return }
        UserStatusManager.status = .login(date: Date.now)
        UserStatusManager.nickname = nickname
        UserStatusManager.profile = output.profile.value
        output.completeTapped.value = ()
    }
    
    private func setRandomImage() {
        let randomNumber = Int.random(in: 0...11)
        output.profile.value = "profile_\(randomNumber)"
    }
    
    private func validateUserInput(text: String?) {
        guard let text = text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            output.statusLabelText.value = " "
            output.statusLabelStatus.value = false
            return
        }
        let isContainsNumber = !(text.allSatisfy{ !$0.isNumber })
        var isContainsSymbol: Bool
        do {
            isContainsSymbol = try text.contains(Regex("[@#$%]"))
        } catch {
            isContainsSymbol = false
        }
        
        if !(2..<10 ~= text.count) {
            output.statusLabelText.value = "2글자 이상 10글자 미만으로 설정해주세요"
            output.statusLabelStatus.value = false

        } else if isContainsSymbol {
            output.statusLabelText.value = "닉네임에 @, #, $, %는 포함할 수 없어요"
            output.statusLabelStatus.value = false

        } else if isContainsNumber {
            output.statusLabelText.value = "닉네임에 숫자는 포함할 수 없어요"
            output.statusLabelStatus.value = false

        } else {
            output.statusLabelText.value = "사용할 수 있는 닉네임이에요"
            output.statusLabelStatus.value = true
        }
        output.isValid.value = output.statusLabelStatus.value && isMbtiFilled
    }
    
    private func mbtiButtonTapped(selected: String?) {
        guard let selected else { return }
        switch selected {
        case "E", "I":
            output.mbti.value[0] = output.mbti.value[0] == selected ? "" : selected
        case "S", "N":
            output.mbti.value[1] = output.mbti.value[1] == selected ? "" : selected
        case "T", "F":
            output.mbti.value[2] = output.mbti.value[2] == selected ? "" : selected
        case "J", "P":
            output.mbti.value[3] = output.mbti.value[3] == selected ? "" : selected
        default:
            return
        }
        isMbtiFilled = output.mbti.value.allSatisfy({ !$0.isEmpty })
        output.isValid.value = output.statusLabelStatus.value && isMbtiFilled
    }


}


extension ProfileNicknameSettingViewModel: ProfileImageDelegate {
    
    func setImage(string: String) {
        output.profile.value = string
    }
    
    
}


protocol ProfileImageDelegate: AnyObject {
    
    func setImage(string: String)
    
    
}
