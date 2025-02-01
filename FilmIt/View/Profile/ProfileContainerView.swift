//
//  ProfileContainerView.swift
//  FilmIt
//
//  Created by 한수빈 on 1/25/25.
//

import UIKit
import SnapKit

final class ProfileContainerView: BaseView {
    
    private let profileButton = ProfileButton(image: UIImage(named: UserStatusManager.profile), isPoint: true)
    
    private let nicknameLabel = {
        let label = UILabel()
        label.text = UserStatusManager.nickname
        label.font = .largeTitle
        label.textColor = .white
        return label
    }()
    
    private let joinDateLabel = {
        let label = UILabel()
        label.text = "25.01.23 가입"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray1
        return label
    }()
    
    private let chevronSymbol = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.forward", withConfiguration: UIImage.SymbolConfiguration(paletteColors: [.gray1]))
        view.contentMode = .scaleAspectFill
        return view
    }()

    private let movieBoxArchiveButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = .point
        config.cornerStyle = .small
        config.attributedTitle = AttributedString(NSAttributedString(string: "0개의 무비박스 보관중", attributes: [.foregroundColor : UIColor.white, .font: UIFont.systemFont(ofSize: 14, weight: .bold)]))
        let button = UIButton()
        button.configuration = config
        return button
    }()
    
    convenience init() {
        self.init(frame: .zero)
        backgroundColor = UIColor(white: 0.15, alpha: 1)
        clipsToBounds = true
        layer.cornerRadius = 12
        isUserInteractionEnabled = true
    }
    
    override func configureHierarchy() {
        [profileButton, nicknameLabel, joinDateLabel, chevronSymbol, movieBoxArchiveButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        profileButton.snp.makeConstraints {
            $0.top.leading.equalTo(safeAreaLayoutGuide).offset(16)
            $0.size.equalTo(50)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(profileButton.snp.trailing).offset(16)
        }
        
        joinDateLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(6)
            $0.leading.equalTo(nicknameLabel.snp.leading)
        }
        
        chevronSymbol.snp.makeConstraints {
            $0.centerY.equalTo(profileButton)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(16)
        }
        
        movieBoxArchiveButton.snp.makeConstraints {
            $0.top.equalTo(profileButton.snp.bottom).offset(16)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
        }
    }
    
    override func configureView() {
        profileButton.configurePointBorder()
        if case .login(let date) = UserStatusManager.status {
            joinDateLabel.text = DateFormatterManager.shared.yyMMDD(date) + " 가입"
        }
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotification), name: .userStatus , object: nil)
    }
    
    @objc private func receiveNotification(value: NSNotification) {
        print("신호 수신")
        if let profile = value.userInfo?["profile"] as? String,
           let nickname = value.userInfo?["nickname"] as? String,
           let likeCount = value.userInfo?["likeCount"] as? Int {
            profileButton.setImage(UIImage(named: profile), for: .normal)
            nicknameLabel.text = nickname
            var config = movieBoxArchiveButton.configuration
            config?.title = "\(likeCount)개의 무비박스 보관중"
            movieBoxArchiveButton.configuration = config
        } else {
            print("제대로 값을 받지 못함")
        }
    }
    
    
}
