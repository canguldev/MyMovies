//
//  HomeCell.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import UIKit
import SnapKit
import Kingfisher

class HomeCell: UICollectionViewCell {
    
    //MARK: - Variables
    static let identifier = "HomeCell"
    
    //MARK: - UI Elements
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "deadpool")
        imageView.backgroundColor = .systemGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    //MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Functions
    func setupCell(viewModel: HomeCellViewModel) {
        self.movieImageView.kf.setImage(with: viewModel.imageURL)
    }
    
    //MARK: - Helper Functions
    private func setupUI() {
        addSubview(movieImageView)
        movieImageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
