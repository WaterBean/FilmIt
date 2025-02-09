//
//  ProfileNicknameSettingView.swift
//  FilmIt
//
//  Created by 한수빈 on 1/25/25.
//

import UIKit
import SnapKit

final class ProfileNicknameSettingView: BaseView {

    let profileButton = ProfileButton(image: nil, isPoint: true)
    
    private let containerView = {
        let view = UIView()
        view.backgroundColor = .activeButton
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let imageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "camera.fill")
        view.tintColor = .white
        return view
    }()
    
    let nicknameTextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textColor = .black
        textField.placeholder = "닉네임을 입력해주세요 :)"
        textField.font = .systemFont(ofSize: 14, weight: .light)
        textField.keyboardAppearance = .default
        return textField
    }()
    
    let nicknameStatusLabel = {
        let label = UILabel()
        label.text = "2글자 이상 10글자 미만으로 설정해주세요"
        label.textColor = .rejectRed
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    let completeButton = {
        var button = ConfirmButton(title: "완료")
        button.isEnabled = false
        return button
    }()
    
    let mbtiView = MBTISelectView()
    
    let isLogin: Bool
    
    init(isLogin: Bool) {
        self.isLogin = isLogin
        super.init(frame: .zero)
    }
    
    override func configureHierarchy() {
        [profileButton, containerView, nicknameTextField, nicknameStatusLabel, mbtiView].forEach {
            addSubview($0)
        }
        if !isLogin {
            addSubview(completeButton)
        }
        containerView.addSubview(imageView)
    }
    
    override func configureLayout() {
        profileButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.size.equalTo(100)
        }
        
        containerView.snp.makeConstraints {
            $0.center.equalTo(profileButton).offset(34)
            $0.size.equalTo(32)
        }
        
        imageView.snp.makeConstraints {
            $0.center.equalTo(containerView)
            $0.size.equalTo(20)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(44)
        }
        
        nicknameStatusLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        mbtiView.snp.makeConstraints {
            $0.top.equalTo(nicknameStatusLabel.snp.bottom).offset(32)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        
        if !isLogin {
            completeButton.snp.makeConstraints {
                $0.bottom.equalTo(safeAreaInsets).inset(48)
                $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
                $0.height.equalTo(44)
            }
        }
    }
    
    override func configureView() {
        backgroundColor = .white
        profileButton.layer.borderWidth = 5
        DispatchQueue.main.async { [self] in
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: -16.0, y: nicknameTextField.frame.height, width: nicknameTextField.frame.width + 32, height: 0.6)
            bottomLine.backgroundColor = UIColor.gray2.cgColor
            nicknameTextField.borderStyle = .none
            nicknameTextField.layer.addSublayer(bottomLine)
        }
    }
    
    
}
