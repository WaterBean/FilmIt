//
//  ProfileImageSettingViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/28/25.
//

import UIKit

final class ProfileImageSettingViewController: UIViewController {
    
    private let mainView = ProfileImageSettingView()
    
    let viewModel = ProfileImageSettingViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    func bind() {
        viewModel.outputProfileSelected.bind { [weak self] profileImageName in
            guard let profileImageName else {
                self?.mainView.profileButton.setImage(UIImage(named: "profile_0"), for: .normal)
                return
            }
            self?.mainView.profileButton.setImage(UIImage(named: profileImageName), for: .normal)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
    
    
}


extension ProfileImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.identifier, for: indexPath) as? ProfileImageCollectionViewCell else { return ProfileImageCollectionViewCell() }
        if "profile_\(indexPath.item)" == viewModel.outputProfileSelected.value {
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
        viewModel.inputProfileSelected.value = imageName
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ProfileImageCollectionViewCell else { return }
        cell.configureCell(imageName: "profile_\(indexPath.item)", isSelected: false)
    }
    
    
}


extension ProfileImageSettingViewController {
    
    private func configureView() {
        navigationItem.title = "PROFILE SETTING"
        mainView.collectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.identifier)
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    
}
