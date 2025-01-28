//
//  ProfileNicknameSettingViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/25/25.
//

import UIKit

final class ProfileNicknameSettingViewController: UIViewController {

    private let mainView = ProfileNicknameSettingView()
    private var isValid = false
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.nicknameTextField.delegate = self
        navigationItem.title = "프로필 설정"
        mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(whenEndEditing)))
        mainView.isUserInteractionEnabled = true
        mainView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        mainView.profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.nicknameTextField.becomeFirstResponder()
    }
    
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
    
    @objc func whenEndEditing(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func completeButtonTapped() {
        if isValid {
            guard let nickname = mainView.nicknameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  let profile = mainView.profileButton.imageView?.image
            else { return }
            UserStatusManager.nickname = nickname
            UserStatusManager.profile = profile
            UserStatusManager.status = .login
            UserStatusManager.status.replaceScene()
        }
    }
    @objc func profileButtonTapped() {
        pushNavigationWithBarButtonItem(vc: ProfileImageSettingViewController(), rightBarButtonItem: nil)
    }
    
    
}


extension ProfileNicknameSettingViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        isValid = validateUserInput(text: text)
    }
    
    
}
