//
//  DetailViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/27/25.
//

import UIKit
import SnapKit

final class MovieDetailViewController: UIViewController {
    
    private let mainView = MovieDetailView()
    private lazy var backdropCollectionView = mainView.backDropView.collectionView
    private lazy var castCollectionView = mainView.castView.collectionView
    private lazy var posterCollectionView = mainView.posterView.collectionView
    private let viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
        viewModel.input.initialLoad.value = ()
    }
    
    func bind() {
        viewModel.output.movieTitle.bind { [weak self] title in
            self?.navigationItem.title = title
        }
        
        viewModel.output.backdrop.bind { [weak self] backdrops in
            self?.backdropCollectionView.reloadData()
        }
        
        viewModel.output.pageControlStatus.bind { [weak self] (count, isHidden) in
            self?.mainView.backDropView.pageControl.numberOfPages = count
            self?.mainView.backDropView.pageControl.isHidden = isHidden
        }
        
        viewModel.output.releaseDate.bind { [weak self] date in
            self?.mainView.backDropView.dateLabel.text = date
        }
       
        viewModel.output.voteAverage.bind { [weak self] average in
            self?.mainView.backDropView.voteAverageLabel.text = average
        }
        
        viewModel.output.genreText.bind { [weak self] text in
            self?.mainView.backDropView.genreIdsLabel.text = text
        }
        
        viewModel.output.overview.bind { [weak self] text in
            self?.mainView.synopsisView.updateView(string: text)
        }
        
        viewModel.output.cast.bind { [weak self] cast in
            self?.castCollectionView.reloadData()
        }

        viewModel.output.poster.bind { [weak self] poster in
            self?.posterCollectionView.reloadData()
        }
        
        
    }
    
    @objc private func pageControlValueChanged(_ sender: UIPageControl) {
        self.backdropCollectionView.scrollToItem(at: IndexPath(item: sender.currentPage, section: 0),at: .centeredHorizontally, animated: true)
    }
    
    @objc private func toggleSynopsisStatus() {
        mainView.synopsisView.foldingButton.isSelected.toggle()
        mainView.synopsisView.updateView(string: viewModel.output.overview.value)
    }
    
    
}

extension MovieDetailViewController {
    
    private func configureUI() {
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
    
}


extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == backdropCollectionView {
            return viewModel.output.backdrop.value.count
        } else if collectionView == castCollectionView {
            return viewModel.output.cast.value.count
        } else if collectionView == posterCollectionView {
            return viewModel.output.poster.value.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.backDropView.collectionView {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackDropImageCollectionViewCell.identifier, for: indexPath) as! BackDropImageCollectionViewCell
            if let item = viewModel.output.backdrop.value[indexPath.item].filePath {
                cell.configureCell(image: item)
            }
            return cell
        } else if collectionView == mainView.castView.collectionView,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as? CastCollectionViewCell {
            let item = viewModel.output.cast.value[indexPath.item]
            cell.configureCell(image: item.profilePath, actorName: item.name, characterName: item.character)
            return cell
        } else if collectionView == mainView.posterView.collectionView,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell,
                  let item = viewModel.output.poster.value[indexPath.item].filePath {
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
