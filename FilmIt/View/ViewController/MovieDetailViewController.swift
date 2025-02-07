//
//  DetailViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/27/25.
//

import UIKit
import SnapKit

final class MovieDetailViewController: UIViewController {
    
    var movie: Movie?
    private var image: ImageResponse? {
        didSet {
            backdropCollectionView.reloadData()
            posterCollectionView.reloadData()
        }
    }
    private var credit: CreditResponse? {
        didSet {
            castCollectionView.reloadData()
        }
    }
    
    private let mainView = MovieDetailView()
    private lazy var backdropCollectionView = mainView.backDropView.collectionView
    private lazy var castCollectionView = mainView.castView.collectionView
    private lazy var posterCollectionView = mainView.posterView.collectionView
    
    override func loadView() {
        view = mainView
    }
    
    private func configureUI() {
        navigationItem.title = movie?.title
        navigationController?.navigationBar.barStyle = .black
        backdropCollectionView.register(BackDropImageCollectionViewCell.self, forCellWithReuseIdentifier: BackDropImageCollectionViewCell.identifier)
        castCollectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
        posterCollectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        [backdropCollectionView, castCollectionView, posterCollectionView].forEach {
            $0.delegate = self
            $0.dataSource = self
            $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        }
        mainView.synopsisView.foldingButton.addTarget(self, action: #selector(toggleSynopsisStatus), for: .touchUpInside)
        mainView.backDropView.pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        guard let movie else { return }
        
        let group = DispatchGroup()
        group.enter()
        MovieNetworkClient.request(ImageResponse.self, router: MovieNetworkRouter.image(id: movie.id)) { result in
            switch result {
            case .success(let success):
                self.image = success
            case .failure(let failure):
                print(failure)
            }
            group.leave()
        }
        group.enter()
        
        MovieNetworkClient.request(CreditResponse.self, router: MovieNetworkRouter.credit(id: movie.id)) { result in
            switch result {
            case .success(let success):
                self.credit = success
            case .failure(let failure):
                print(failure)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.mainView.synopsisView.updateView(string: movie.overview)
            self.mainView.backDropView.updateView(releaseDate: movie.releaseDate, voteAverage: movie.voteAverage, genreIds: movie.genreIds)
        }
    }
    
    @objc private func pageControlValueChanged(_ sender: UIPageControl) {
        self.backdropCollectionView.scrollToItem(at: IndexPath(item: sender.currentPage, section: 0),at: .centeredHorizontally, animated: true)
    }
    
    @objc private func toggleSynopsisStatus() {
        mainView.synopsisView.foldingButton.isSelected.toggle()
        mainView.synopsisView.updateView(string: movie?.overview)
    }
    
    
}


extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == backdropCollectionView {
            guard let count = image?.backdrops.count else {
                mainView.backDropView.pageControl.numberOfPages = 0
                return 0
            }
            mainView.backDropView.pageControl.isHidden = (count < 2)
            if count >= 5 {
                mainView.backDropView.pageControl.numberOfPages = 5
                return 5
            } else if 1...5 ~= count {
                mainView.backDropView.pageControl.numberOfPages = count
                return count
            } else {
                mainView.backDropView.pageControl.numberOfPages = 1
                return 1
            }
        } else if collectionView == castCollectionView {
            return credit?.cast.count ?? 0
        } else if collectionView == posterCollectionView {
            return image?.posters.count ?? 0
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.backDropView.collectionView {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackDropImageCollectionViewCell.identifier, for: indexPath) as! BackDropImageCollectionViewCell
            if let item = image?.backdrops[safe: indexPath.item]?.filePath {
                cell.configureCell(image: item)
            }
            return cell
        } else if collectionView == mainView.castView.collectionView,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as? CastCollectionViewCell,
                  let item = credit?.cast[indexPath.item] {
            cell.configureCell(image: item.profilePath, actorName: item.name, characterName: item.character)
            return cell
        } else if collectionView == mainView.posterView.collectionView,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell,
                  let item = image?.posters[indexPath.item].filePath {
            cell.configureCell(image: item)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == backdropCollectionView {
            let width = collectionView.frame.width
            let height = width * (2.0/3.0)
            return CGSize(width: width, height: height)
        } else if collectionView == castCollectionView {
            return CGSize(width: (collectionView.frame.width - 48.0) / 2.16, height: (collectionView.frame.height - 48.0) / 2.0)
        } else if collectionView == posterCollectionView {
            return CGSize(width: (collectionView.frame.width - 72.0) / 3.0, height: collectionView.frame.height - 36.0)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        mainView.backDropView.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        mainView.backDropView.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    
}
