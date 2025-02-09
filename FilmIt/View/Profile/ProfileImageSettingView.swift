//
//  ProfileImageSettingView.swift
//  FilmIt
//
//  Created by 한수빈 on 1/28/25.
//

import UIKit
import SnapKit

final class ProfileImageSettingView: BaseView {
    
    let profileButton = ProfileButton(isPoint: true)
    
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
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {
        let layout = UICollectionViewFlowLayout()
        let inset = 16.0
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.scrollDirection = .vertical
        let width = (UIScreen.main.bounds.width - 32.0 - 48.0) / 4
        layout.itemSize = CGSize(width: width, height: width)
        return layout
    }())
    
    override func configureHierarchy() {
        [profileButton, containerView, collectionView].forEach {
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
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(40)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        backgroundColor = .white
        profileButton.configurePointBorder()
        profileButton.layer.borderWidth = 5
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isMultipleTouchEnabled = false
        collectionView.backgroundColor = .white
    }
    
    
}
