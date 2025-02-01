//
//  BackDropImageCollectionViewCell.swift
//  FilmIt
//
//  Created by 한수빈 on 1/27/25.
//

import UIKit
import Kingfisher
import SnapKit

final class BackDropImageCollectionViewCell: BaseCollectionViewCell {
    
    private let backDropImageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(backDropImageView)
    }
    
    override func configureLayout() {
        backDropImageView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }

    }
    
    override func configureView() {
        backDropImageView.image = UIImage(
            systemName: "photo.artframe",
            withConfiguration: SFConfig.preferringMonochrome()
                .applying(SFConfig(pointSize: 12, weight: .light)))
        backDropImageView.tintColor = .movieBoxButton
    }

    func configureCell(image: String) {
        backDropImageView.kf.setImage(with: URL(string: image.toBigImageURL()))
    }
    
    
}
