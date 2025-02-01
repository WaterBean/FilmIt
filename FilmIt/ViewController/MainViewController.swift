//
//  MainViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/25/25.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let mainView = MainView()
    private var trendingMovieList = [Movie]() {
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
        mainView.recentSearchTermsView.delegate = self
        mainView.recentSearchTermsView.deleteRecentsButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        mainView.profileContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileViewTapped)))
        MovieNetworkClient.request(TrendingResponse.self, router: .trending) {
            self.trendingMovieList = $0.results
        } failure: { error in
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.recentSearchTermsView.updateSearchTerms()
        mainView.collectionView.reloadData()
    }
    
    @objc private func searchButtonTapped() {
        pushNavigationWithBarButtonItem(vc: SearchViewController(), rightBarButtonItem: nil)
    }
    
    @objc private func deleteButtonTapped() {
        UserStatusManager.removeAllSearchTerms()
        mainView.recentSearchTermsView.updateSearchTerms()
    }
    
    @objc private func profileViewTapped() {
        presentProfileSetting()
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
        cell.configureCell(id: item.id, image: item.posterPath, title: item.title, overView: item.overview)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let collectionViewSize = collectionView.frame.size.width - (padding * 2)
        return CGSize(width: collectionViewSize * (9.0/16.0), height: collectionViewSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = trendingMovieList[indexPath.item]
        let vc = MovieDetailViewController()
        vc.movie = item
        let rightBarButtonItem = UIBarButtonItem(customView: LikeButton(id: item.id))
        pushNavigationWithBarButtonItem(vc: vc, rightBarButtonItem: rightBarButtonItem)
    }

    
}

extension MainViewController: RecentSearchTermsButtonDelegate {
    
    func deleteTerm(_ term: String) {
        UserStatusManager.removeSearchTerm(keyword: term)
        mainView.recentSearchTermsView.updateSearchTerms()
    }
    
    
    func searchTerm(_ term: String) {
        let vc = SearchViewController()
        vc.searchWithInitialTerm(term: term)
        pushNavigationWithBarButtonItem(vc: vc, rightBarButtonItem: nil)
    }
    
    
}
