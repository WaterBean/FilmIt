//
//  ProfileNicknameSettingViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/25/25.
//

import UIKit

final class ProfileNicknameSettingViewController: UIViewController {
    
    private let mainView = ProfileNicknameSettingView(isLogin: UserStatusManager.status == .login)
    private var isValid = false
    private var profileImageName = UserStatusManager.profile
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "프로필 설정"
        mainView.nicknameTextField.delegate = self
        mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(whenEndEditing)))
        mainView.isUserInteractionEnabled = true
        mainView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        mainView.profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        switch UserStatusManager.status {
        case .login:
            mainView.profileButton.setImage(UIImage(named: UserStatusManager.profile), for: .normal)
            mainView.nicknameTextField.text = UserStatusManager.nickname
            validateUserInput(text: UserStatusManager.nickname)
        case .logout:
            setRandomImage(mainView.profileButton)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.nicknameTextField.becomeFirstResponder()
    }
    
    @discardableResult
    private func validateUserInput(text: String) -> Bool {
        let isContainsNumber = !(text.allSatisfy{ !$0.isNumber })
        var isContainsSymbol: Bool
        do {
            isContainsSymbol = try text.contains(Regex("[@#$%]"))
        } catch {
            isContainsSymbol = false
        }
        
        if !(2..<10 ~= text.count) {
            mainView.nicknameStatusLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
        } else if isContainsSymbol {
            mainView.nicknameStatusLabel.text = "닉네임에 @, #, $, %는 포함할 수 없어요"
        } else if isContainsNumber {
            mainView.nicknameStatusLabel.text = "닉네임에 숫자는 포함할 수 없어요"
        } else {
            mainView.nicknameStatusLabel.text = "사용할 수 있는 닉네임이에요"
            return true
        }
        
        return false
    }
    
    @objc private func whenEndEditing(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func completeButtonTapped() {
        saveUserData()
        UserStatusManager.status.replaceScene()
    }
    
    
    @objc func saveButtonTapped() {
        saveUserData()
        dismissButtonTapped()
    }
    
    @objc private func profileButtonTapped() {
        let vc = ProfileImageSettingViewController()
        vc.profileImageName = profileImageName
        vc.delegate = self
        pushNavigationWithBarButtonItem(vc: vc, rightBarButtonItem: nil)
    }
    
    @objc func dismissButtonTapped() {
        dismiss(animated: true)
    }

    private func saveUserData() {
        guard isValid, let nickname = mainView.nicknameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        UserStatusManager.status = .login
        UserStatusManager.nickname = nickname
        UserStatusManager.profile = profileImageName
    }
    
    private func setRandomImage(_ button: UIButton) {
        let randomNumber = Int.random(in: 0...11)
        button.setImage(UIImage(named: "profile_\(randomNumber)"), for: .normal)
        profileImageName = "profile_\(randomNumber)"
    }
    
    
}


extension ProfileNicknameSettingViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        isValid = validateUserInput(text: text)
    }
    
    
}

extension ProfileNicknameSettingViewController: ProfileImageDelegate {
    
    func setImage(string: String) {
        profileImageName = string
        mainView.profileButton.setImage(UIImage(named: string), for: .normal)
    }
    
    
}


protocol ProfileImageDelegate: AnyObject {
    
    func setImage(string: String)
    
    
}


