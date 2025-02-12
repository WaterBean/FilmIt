//
//  MainViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/25/25.
//

import UIKit

final class MainViewController: UIViewController {
    
    private lazy var mainView = MainView(recentSearchTermsView: RecentSearchTermsView(viewModel: recentSearchTermsViewModel))
    
    let todayMovieViewModel = TodayMovieViewModel()
    let recentSearchTermsViewModel = RecentSearchTermsViewModel()

    private func bind() {
        
        mainView.profileContainerView.viewModel.output.presentProfileSetting.lazyBind { [weak self] _ in
            self?.presentProfileSetting()
        }
        
        recentSearchTermsViewModel.output.searchWithTerm.lazyBind { [weak self] string in
            guard let self else { return }
            let vc = SearchViewController()
            vc.searchWithInitialTerm(term: string)
            pushNavigationWithBarButtonItem(vc: vc, rightBarButtonItem: nil)
        }
        
        recentSearchTermsViewModel.output.search.lazyBind { [weak self] _ in
            guard let self else { return }
            pushNavigationWithBarButtonItem(vc: SearchViewController(), rightBarButtonItem: nil)
        }
        
        todayMovieViewModel.output.trendingMovieList.bind { [weak self] todayMovieList in
            self?.mainView.collectionView.reloadData()
        }
    }
    
    private func configureView() {
        navigationItem.title = "오늘의 영화"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        
        mainView.collectionView.register(TodayMoviesCollectionViewCell.self, forCellWithReuseIdentifier: TodayMoviesCollectionViewCell.identifier)
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.recentSearchTermsView.delegate = self
        mainView.recentSearchTermsView.deleteRecentsButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        mainView.profileContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileViewTapped)))
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
        todayMovieViewModel.input.initialFetch.value = ()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recentSearchTermsViewModel.input.update.value = ()
    }
    
    @objc private func searchButtonTapped() {
        recentSearchTermsViewModel.input.search.value = ()
    }
    
    @objc private func deleteButtonTapped() {
        recentSearchTermsViewModel.input.removeAllTerms.value = ()
    }
    
    @objc private func profileViewTapped() {
        mainView.profileContainerView.viewModel.input.tapped.value = (())
    }
    
    
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        todayMovieViewModel.output.trendingMovieList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = todayMovieViewModel.output.trendingMovieList.value[indexPath.item]
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
        let item = todayMovieViewModel.output.trendingMovieList.value[indexPath.item]
        let vc = MovieDetailViewController(viewModel: MovieDetailViewModel(movie: item))
        let rightBarButtonItem = UIBarButtonItem(customView: LikeButton(id: item.id))
        pushNavigationWithBarButtonItem(vc: vc, rightBarButtonItem: rightBarButtonItem)
    }

    
}

extension MainViewController: RecentSearchTermsButtonDelegate {
    
    func deleteTerm(_ term: String) {
        recentSearchTermsViewModel.input.deleteTerm.value = term
    }
    
    
    func searchTerm(_ term: String) {
        recentSearchTermsViewModel.input.searchWithTerm.value = term
    }
    
    
}
