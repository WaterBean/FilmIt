//
//  CastCollectionViewCell.swift
//  FilmIt
//
//  Created by 한수빈 on 1/28/25.
//

import UIKit
import Kingfisher
import SnapKit

final class CastCollectionViewCell: BaseCollectionViewCell {
    
    private let castImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.tintColor = .movieBoxButton
        return view
    }()
    
    private let actorNameLabel = {
        let label = UILabel()
        label.text = " "
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let characterNameLabel = {
        let label = UILabel()
        label.text = " "
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray2
        return label
    }()
    
    override func configureHierarchy() {
        [castImageView, actorNameLabel, characterNameLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        castImageView.snp.makeConstraints {
            $0.leading.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
            $0.size.equalTo(50)
        }
        
        actorNameLabel.snp.makeConstraints {
            $0.leading.equalTo(castImageView.snp.trailing).offset(16)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide)
            $0.top.equalTo(contentView.safeAreaLayoutGuide).offset(6)
        }
        
        characterNameLabel.snp.makeConstraints {
            $0.leading.equalTo(castImageView.snp.trailing).offset(16)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide)
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-8)
        }
    }
    
    override func configureView() {
        DispatchQueue.main.async {
            self.castImageView.layer.cornerRadius = self.castImageView.frame.width / 2
        }
    }
    
    
    func configureCell(image: String?, actorName: String, characterName: String) {
        actorNameLabel.text = actorName
        characterNameLabel.text = characterName
        guard let image else {
            castImageView.image = UIImage(
                systemName: "person.circle",
                withConfiguration: SFConfig.preferringMonochrome()
                    .applying(SFConfig(pointSize: 12, weight: .light)))
            return
        }
        castImageView.kf.setImage(with: URL(string: image.toImageURL()),
                                  placeholder: UIImage(
                                    systemName: "person.circle",
                                    withConfiguration: SFConfig.preferringMonochrome()
                                        .applying(SFConfig(pointSize: 12, weight: .light))))
    }
    
    
}
