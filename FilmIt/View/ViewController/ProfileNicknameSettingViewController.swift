//
//  ProfileNicknameSettingViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/25/25.
//

import UIKit

final class ProfileNicknameSettingViewController: UIViewController {
    
    private let mainView = ProfileNicknameSettingView(isLogin: UserStatusManager.status != .logout)
    
    let viewModel = ProfileNicknameSettingViewModel()
    
    private func bind() {
        viewModel.outputProfile.bind { [weak self] string in
            self?.mainView.profileButton.setImage(UIImage(named: string), for: .normal)
        }
        
        viewModel.outputStatusLabelText.bind {[weak self] string in
            self?.mainView.nicknameStatusLabel.text = string
        }
        
        viewModel.outputStatusLabelStatus.bind { [weak self] isValid in
            self?.mainView.nicknameStatusLabel.textColor = isValid ? .activeButton : .rejectRed
        }
        
        viewModel.outputProfileButtonTapped.lazyBind { [weak self] string in
            let vc = ProfileImageSettingViewController()
            vc.viewModel.delegate = self?.viewModel
            vc.viewModel.inputProfileSelected.value = string
            self?.pushNavigationWithBarButtonItem(vc: vc, rightBarButtonItem: nil)
            
        }
        
        viewModel.outputCompleteButtonTapped.lazyBind {     UserStatusManager.status.replaceScene()
        }
        
        viewModel.outputMBTIButtonTapped.lazyBind { [weak self] buttonStatus in
            guard let self else { return }

            let (selected, isButton1Selected, isButton2Selected) = buttonStatus
            switch selected {
            case "E", "I":
                mainView.mbtiView.e.isSelected = isButton1Selected
                mainView.mbtiView.i.isSelected = isButton2Selected
            case "S", "N":
                mainView.mbtiView.s.isSelected = isButton1Selected
                mainView.mbtiView.n.isSelected = isButton2Selected
            case "T", "F":
                mainView.mbtiView.t.isSelected = isButton1Selected
                mainView.mbtiView.f.isSelected = isButton2Selected
            case "J", "P":
                mainView.mbtiView.j.isSelected = isButton1Selected
                mainView.mbtiView.p.isSelected = isButton2Selected
            default: break
            }
        }
        
        
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.nicknameTextField.becomeFirstResponder()
    }
    
    @objc private func whenEndEditing(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func completeButtonTapped() {
        viewModel.inputCompleteButtonTapped.value = ()
    }
    
    @objc private func profileButtonTapped() {
        viewModel.inputProfileButtonTapped.value = ()
    }
    
    @objc func saveButtonTapped() {
        completeButtonTapped()
        dismissButtonTapped()
    }
    
    @objc func dismissButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func mbtiButtonTapped(_ sender: UIButton) {
        viewModel.inputMBTIButtonTapped.value = sender.titleLabel?.text
    }
    

}


extension ProfileNicknameSettingViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.inputNicknameText.value = textField.text
    }
    
    
}


extension ProfileNicknameSettingViewController {
    
    private func configureView() {
        navigationItem.title = "PROFILE SETTING"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.largeTitle
        ]
        navigationController?.navigationBar.tintColor = .black
        
        mainView.nicknameTextField.delegate = self
        mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(whenEndEditing)))
        mainView.isUserInteractionEnabled = true
        mainView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        mainView.profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        
        mainView.mbtiView.mbtiButtons.forEach {
            $0.addTarget(self, action: #selector(mbtiButtonTapped), for: .touchUpInside)
        }
    }
    
    
}
