//
//  ProfileNicknameSettingViewModel.swift
//  FilmIt
//
//  Created by 한수빈 on 2/9/25.
//

import Foundation

final class ProfileNicknameSettingViewModel {
    
    let inputViewDidLoad: Observable<Bool> = Observable(false)
    let inputProfileButtonTapped: Observable<Void> = Observable(())
    let inputNicknameText: Observable<String?> = Observable(nil)
    let inputCompleteButtonTapped: Observable<Void> = Observable(())
    
    let outputStatusLabelText: Observable<String?> = Observable(nil)
    let outputStatusLabelStatus = Observable(false)
    let outputProfile: Observable<String> = Observable(UserStatusManager.profile)
    let outputProfileButtonTapped: Observable<String> = Observable("")
    let outputCompleteButtonTapped: Observable<Void> = Observable(())

    init() {
        
        inputViewDidLoad.bind { [weak self] inNickname in
            switch UserStatusManager.status {
            case .logout:
                self?.setRandomImage()
            case .login:
                self?.inputNicknameText.value = UserStatusManager.profile
                self?.inputNicknameText.value = UserStatusManager.nickname
                self?.validateUserInput(text: UserStatusManager.nickname)
            }
        }
        
        inputNicknameText.bind { [weak self] text in
            self?.validateUserInput(text: text)
        }
        
        inputProfileButtonTapped.lazyBind { [weak self] in
            guard let self else { return }
            self.outputProfileButtonTapped.value = self.outputProfile.value
        }
        
        inputCompleteButtonTapped.lazyBind { [weak self] in
            self?.saveUserData()
        }
        
    }
    
    private var isValid = false
    
    private func saveUserData() {
        guard isValid, let nickname = inputNicknameText.value else { return }
        UserStatusManager.status = .login(date: Date.now)
        UserStatusManager.nickname = nickname
        UserStatusManager.profile = outputProfile.value
    }
    
    private func setRandomImage() {
        let randomNumber = Int.random(in: 0...11)
        outputProfile.value = "profile_\(randomNumber)"
    }
    
    private func validateUserInput(text: String?) {
        guard let text = text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            outputStatusLabelText.value = " "
            outputStatusLabelStatus.value = false
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
            outputStatusLabelText.value = "2글자 이상 10글자 미만으로 설정해주세요"
            outputStatusLabelStatus.value = false

        } else if isContainsSymbol {
            outputStatusLabelText.value = "닉네임에 @, #, $, %는 포함할 수 없어요"
            outputStatusLabelStatus.value = false

        } else if isContainsNumber {
            outputStatusLabelText.value = "닉네임에 숫자는 포함할 수 없어요"
            outputStatusLabelStatus.value = false

        } else {
            outputStatusLabelText.value = "사용할 수 있는 닉네임이에요"
            outputStatusLabelStatus.value = true
        }
        
    }
    
    
}
