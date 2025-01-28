//
//  DetailViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/27/25.
//

import UIKit
import SnapKit

final class MovieDetailViewController: UIViewController {
    
    let mainView = MovieDetailView()
    private lazy var backdropCollectionView = mainView.backDropView.collectionView
    private lazy var castCollectionView = mainView.castView.collectionView
    private lazy var posterCollectionView = mainView.posterView.collectionView
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backdropCollectionView.delegate = self
        backdropCollectionView.dataSource = self
        backdropCollectionView.register(BackDropImageCollectionViewCell.self, forCellWithReuseIdentifier: BackDropImageCollectionViewCell.identifier)
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
        posterCollectionView.delegate = self
        posterCollectionView.dataSource = self
        posterCollectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
    }
    
    
}


extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == backdropCollectionView {
            return 4
        } else if collectionView == castCollectionView {
            return 100
        } else if collectionView == posterCollectionView {
            return 6
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == backdropCollectionView,
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackDropImageCollectionViewCell.identifier, for: indexPath) as? BackDropImageCollectionViewCell {
            cell.configureView()
            return cell
        } else if collectionView == castCollectionView,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as? CastCollectionViewCell {
            cell.configureView()
            return cell
        } else if collectionView == posterCollectionView,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell {
            cell.configureView()
            return cell
        } else {
            return BaseCollectionViewCell()
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
