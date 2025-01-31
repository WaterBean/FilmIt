//
//  PosterCollectionViewCell.swift
//  FilmIt
//
//  Created by 한수빈 on 1/28/25.
//

import UIKit
import Kingfisher
import SnapKit

final class PosterCollectionViewCell: BaseCollectionViewCell {
    
    private let posterImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
        
    override func configureHierarchy() {
        [posterImageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        posterImageView.image = .profile0
    }
    
    func configureCell(image: String) {
        posterImageView.kf.setImage(with: URL(string: image.toImageURL()))
    }


}
