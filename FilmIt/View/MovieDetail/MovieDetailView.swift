//
//  MovieDetailView.swift
//  FilmIt
//
//  Created by 한수빈 on 1/27/25.
//

import UIKit
import SnapKit

final class MovieDetailView: BaseView {
    
    private let scrollView = {
        let view = UIScrollView()
        view.alwaysBounceHorizontal = false
        view.backgroundColor = .black
        return view
    }()
    private let contentView = BaseView()
    
    let backDropView = BackDropView()
    let synopsisView = SynopsisView()
    let castView = CastView()
    let posterView = PosterView()
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        [backDropView, synopsisView, castView,posterView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(scrollView.snp.width)
            $0.verticalEdges.equalTo(scrollView)
        }
        
        backDropView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView)
        }
        
        synopsisView.snp.makeConstraints {
            $0.top.equalTo(backDropView.snp.bottom)
            $0.horizontalEdges.equalTo(contentView)
        }
        
        castView.snp.makeConstraints {
            $0.top.equalTo(synopsisView.snp.bottom)
            $0.horizontalEdges.equalTo(contentView)
        }

        posterView.snp.makeConstraints {
            $0.top.equalTo(castView.snp.bottom)
            $0.bottom.equalTo(contentView)
            $0.horizontalEdges.equalTo(contentView)
        }
    }
    
    override func configureView() {
        
    }
    
    
}


