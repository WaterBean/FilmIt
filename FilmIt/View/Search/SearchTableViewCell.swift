//
//  SearchTableViewCell.swift
//  FilmIt
//
//  Created by 한수빈 on 1/26/25.
//

import UIKit
import Kingfisher
import SnapKit

final class SearchTableViewCell: BaseTableViewCell {
    
    private let posterImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .gray1
        return label
    }()
    
    private let tagLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.backgroundColor = .gray2
        label.textColor = .white
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()
    
    private let tagLabel2 = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.backgroundColor = .gray2
        label.textColor = .white
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()
    
    private let stackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        return view
    }()
    
    private let likeButton = LikeButton()
    
    override func configureHierarchy() {
        [posterImageView, titleLabel, dateLabel, stackView, likeButton].forEach {
            contentView.addSubview($0)
        }
        
        [tagLabel, tagLabel2].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).offset(16)
            $0.verticalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            $0.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top).offset(4)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(16)
            $0.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(16)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(posterImageView.snp.trailing).offset(16)
            $0.height.equalTo(20)
            $0.bottom.equalTo(posterImageView.snp.bottom)
        }
        
        likeButton.snp.makeConstraints {
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(10)
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.size.equalTo(44)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .black
        posterImageView.image = .profile10
        titleLabel.text = "기생충"
        dateLabel.text = "8888. 88. 88"
        tagLabel.text = " 장르 정보 없음 "
        tagLabel2.text = " "
        selectionStyle = .none
    }
    
    func configureCell(id: Int, image: String?, title: String, date: String, tag: [Int]) {
        likeButton.id = id
        titleLabel.text = title
        dateLabel.text = DateFormatterManager.shared.yyyyMMdd(date)
        let genre = MovieGenre.getGenreNames(tag)
        if let second = genre[safe: 1], let first = genre[safe: 0] {
            tagLabel.text = " \(first) "
            tagLabel2.text = " \(second) "
        } else if let first = genre[safe: 0] {
            tagLabel.text = " \(first) "
            tagLabel2.text = ""
        } else {
            tagLabel.text = " 장르 정보 없음 "
            tagLabel2.text = ""
        }
        guard let image else { return }
        posterImageView.kf.setImage(with: URL(string: SecretManager.imageURL + image))
    }

    
}
