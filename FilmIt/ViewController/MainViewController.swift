//
//  MainViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/25/25.
//

import UIKit

final class MainViewController: UIViewController {
    
    let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "오늘의 영화"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        
        mainView.collectionView.register(TodayMoviesCollectionViewCell.self, forCellWithReuseIdentifier: TodayMoviesCollectionViewCell.identifier)
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.recentSearchTermsView.deleteRecentsButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.recentSearchTermsView.updateSearchTerms()
    }
    
    @objc func searchButtonTapped() {
        let vc = SearchViewController()
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func deleteButtonTapped() {
        UserStatusManager.removeAllSearchTerms()
        mainView.recentSearchTermsView.updateSearchTerms()
    }
    
    
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayMoviesCollectionViewCell.identifier, for: indexPath) as? TodayMoviesCollectionViewCell else {
            return TodayMoviesCollectionViewCell()
        }
        cell.configureView()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let collectionViewSize = collectionView.frame.size.width - (padding * 2)
        return CGSize(width: collectionViewSize * (9.0/16.0), height: collectionViewSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        vc.navigationItem.title = "대충영화이름"
        navigationController?.pushViewController(vc, animated: true)
    }

    
}
