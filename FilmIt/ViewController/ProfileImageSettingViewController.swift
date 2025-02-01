//
//  ProfileImageSettingViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/28/25.
//

import UIKit

final class ProfileImageSettingViewController: UIViewController {

    private let mainView = ProfileImageSettingView()
    var profileImageName: String?
    weak var delegate: ProfileImageDelegate?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonImage(mainView.profileButton)
        navigationItem.title = "프로필 이미지 설정"
        mainView.collectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.identifier)
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }

    private func setButtonImage(_ button: UIButton) {
        guard let profileImageName else {
            button.setImage(UIImage(named: "profile_0"), for: .normal)
            return
        }
        button.setImage(UIImage(named: profileImageName), for: .normal)
        delegate?.setImage(string: profileImageName)
    }
    
    
}


extension ProfileImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.identifier, for: indexPath) as? ProfileImageCollectionViewCell else { return ProfileImageCollectionViewCell() }
        if "profile_\(indexPath.item)" == profileImageName {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
            cell.configureCell(imageName: "profile_\(indexPath.item)", isSelected: true)
        } else {
            cell.configureCell(imageName: "profile_\(indexPath.item)", isSelected: false)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ProfileImageCollectionViewCell else { return }
        let imageName = "profile_\(indexPath.item)"
        cell.configureCell(imageName: imageName, isSelected: true)
        profileImageName = imageName
        setButtonImage(mainView.profileButton)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ProfileImageCollectionViewCell else { return }
        cell.configureCell(imageName: "profile_\(indexPath.item)", isSelected: false)
    }
    
    
}
