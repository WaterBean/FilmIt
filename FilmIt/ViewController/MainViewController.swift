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
        
        mainView.collectionView.register(TodayMoviesCollectionViewCell.self, forCellWithReuseIdentifier: "TodayMoviesCollectionViewCell")
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayMoviesCollectionViewCell", for: indexPath) as? TodayMoviesCollectionViewCell else {
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
    
    
}
