//
//  ProfileImageSettingView.swift
//  FilmIt
//
//  Created by 한수빈 on 1/28/25.
//

import UIKit
import SnapKit

final class ProfileImageSettingView: BaseView {
    
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
    
    override func configureHierarchy() {
        [profileButton, containerView].forEach {
            addSubview($0)
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
        
    }
    
    override func configureView() {
        profileButton.configurePointBorder()
    }
    
}
