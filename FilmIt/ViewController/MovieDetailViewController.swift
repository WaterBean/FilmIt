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
    var image: ImageResponse? {
        didSet {
            backdropCollectionView.reloadData()
            posterCollectionView.reloadData()
        }
    }
    var credit: CreditResponse? {
        didSet {
            castCollectionView.reloadData()
        }
    }
    
    let mainView = MovieDetailView()
    private lazy var backdropCollectionView = mainView.backDropView.collectionView
    private lazy var castCollectionView = mainView.castView.collectionView
    private lazy var posterCollectionView = mainView.posterView.collectionView
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backdropCollectionView.register(BackDropImageCollectionViewCell.self, forCellWithReuseIdentifier: BackDropImageCollectionViewCell.identifier)
        castCollectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
        posterCollectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        [backdropCollectionView, castCollectionView, posterCollectionView].forEach {
            $0.delegate = self
            $0.dataSource = self
            $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        }
        
        guard let movie else { return }
        navigationItem.title = movie.title
        MovieNetworkClient.request(ImageResponse.self, router: .image(id: movie.id)) {
            self.image = $0
        } failure: { error in
            print(error)
        }
        MovieNetworkClient.request(CreditResponse.self, router: .credit(id: movie.id)) {
            self.credit = $0
        } failure: { error in
            print(error)
        }
        mainView.synopsisView.updateView(string: movie.overview)
        mainView.backDropView.updateView(releaseDate: movie.releaseDate, voteAverage: movie.voteAverage, genreIds: movie.genreIds)
    }
    
    
}


extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == backdropCollectionView {
            return image?.backdrops.count ?? 0
        } else if collectionView == castCollectionView {
            return credit?.cast.count ?? 0
        } else if collectionView == posterCollectionView {
            return image?.posters.count ?? 0
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.backDropView.collectionView,
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackDropImageCollectionViewCell.identifier, for: indexPath) as? BackDropImageCollectionViewCell,
           let item = image?.backdrops[indexPath.item].filePath {
            cell.configureCell(image: item)
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
            return CGSize(width: (collectionView.frame.width - 48.0) / 2.0, height: (collectionView.frame.height - 48.0) / 2)
        } else if collectionView == posterCollectionView {
            return CGSize(width: (collectionView.frame.width - 72.0) / 3.0, height: collectionView.frame.height - 36.0)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    
    
}
