//
//  MainViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/25/25.
//

import UIKit

final class MainViewController: UIViewController {
    
    let mainView = MainView()
    var trendingMovieList = [Movie]() {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
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
        mainView.profileContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileViewTapped)))
//        MovieNetworkClient.request(TrendingResponse.self, router: .trending) {
//            self.trendingMovieList = $0.results
//        } failure: { error in
//            print(error)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.recentSearchTermsView.updateSearchTerms()
        
    }
    
    @objc private func searchButtonTapped() {
        pushNavigationWithBarButtonItem(vc: SearchViewController(), rightBarButtonItem: nil)
    }
    
    @objc private func deleteButtonTapped() {
        UserStatusManager.removeAllSearchTerms()
        mainView.recentSearchTermsView.updateSearchTerms()
    }
    
    @objc private func profileViewTapped() {
        let vc = ProfileNicknameSettingViewController()
        let nav = UINavigationController(rootViewController: vc)
        let saveButton = UIBarButtonItem(title: "저장", image: nil, target: vc, action: #selector(vc.saveButtonTapped))
        saveButton.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .normal)
        let dismissButton = UIBarButtonItem(title: " ", image: UIImage(systemName: "xmark"), target: vc, action: #selector(vc.dismissButtonTapped))
        nav.navigationBar.topItem?.rightBarButtonItem = saveButton
        nav.navigationBar.topItem?.leftBarButtonItem = dismissButton
        nav.sheetPresentationController?.prefersGrabberVisible = true
        present(nav, animated: true)
    }
    
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        trendingMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = trendingMovieList[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayMoviesCollectionViewCell.identifier, for: indexPath) as? TodayMoviesCollectionViewCell else {
            return TodayMoviesCollectionViewCell()
        }
        cell.configureCell(image: item.posterPath, title: item.title, overView: item.overview)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let collectionViewSize = collectionView.frame.size.width - (padding * 2)
        return CGSize(width: collectionViewSize * (9.0/16.0), height: collectionViewSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushNavigationWithBarButtonItem(vc: MovieDetailViewController(), rightBarButtonItem: nil)
    }

    
}
