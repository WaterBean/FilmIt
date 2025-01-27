//
//  DetailViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/27/25.
//

import UIKit
import SnapKit

final class MovieDetailViewController: UIViewController {

    lazy private var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 200
        view.register(BackDropTableViewCell.self, forCellReuseIdentifier: BackDropTableViewCell.identifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
}


extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackDropTableViewCell.identifier) as? BackDropTableViewCell else { return BackDropTableViewCell() }
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(BackDropImageCollectionViewCell.self, forCellWithReuseIdentifier: BackDropImageCollectionViewCell.identifier)
        cell.collectionView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        400
    }
    
    
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackDropImageCollectionViewCell.identifier, for: indexPath) as? BackDropImageCollectionViewCell else {
            return BackDropImageCollectionViewCell()
        }
        cell.configureView()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = width * (2.0/3.0)
        return CGSize(width: width, height: height)
    }
    
    
}
