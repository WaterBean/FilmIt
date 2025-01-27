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
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backDropView.collectionView.delegate = self
        mainView.backDropView.collectionView.dataSource = self
        mainView.backDropView.collectionView.register(BackDropImageCollectionViewCell.self, forCellWithReuseIdentifier: BackDropImageCollectionViewCell.identifier)

    }
    
    
}


extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackDropImageCollectionViewCell.identifier, for: indexPath) as? BackDropImageCollectionViewCell {
            cell.configureView()
            return cell
        }
        return BaseCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = width * (2.0/3.0)
        return CGSize(width: width, height: height)
    }
    
    
}
