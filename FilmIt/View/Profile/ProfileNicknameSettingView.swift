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
        view.backgroundColor = .point
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
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 14, weight: .light)
        textField.keyboardAppearance = .dark
        return textField
    }()
    
    let nicknameStatusLabel = {
        let label = UILabel()
        label.text = "2글자 이상 10글자 미만으로 설정해주세요"
        label.textColor = .point
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    let completeButton = CapsuleBorderButton(title: "완료")
    
    let isLogin: Bool
    
    init(isLogin: Bool) {
        self.isLogin = isLogin
        super.init(frame: .zero)
    }
    
    override func configureHierarchy() {
        [profileButton, containerView, nicknameTextField, nicknameStatusLabel].forEach {
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
        if !isLogin {
            completeButton.snp.makeConstraints {
                $0.top.equalTo(nicknameStatusLabel.snp.bottom).offset(32)
                $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
                $0.height.equalTo(44)
            }
        }
    }
    
    override func configureView() {
        DispatchQueue.main.async { [self] in
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: -16.0, y: nicknameTextField.frame.height, width: nicknameTextField.frame.width+32, height: 0.6)
            bottomLine.backgroundColor = UIColor.white.cgColor
            nicknameTextField.borderStyle = .none
            nicknameTextField.layer.addSublayer(bottomLine)
        }
    }
    
    
}
