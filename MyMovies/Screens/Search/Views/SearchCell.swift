//
//  SearchCell.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import UIKit
import SnapKit

class SearchCell: UICollectionViewCell {
    
    //MARK: - Variables
    static let identifier = "SearchCell"
    
    //MARK: - UI Elements
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Functions
    func setupCell(viewModel: SearchCellViewModel) {
        self.movieImageView.kf.setImage(with: viewModel.imageURL)
        self.movieTitleLabel.text = viewModel.title
    }
    
    private func setupUI() {
        addSubviewsFromExt(movieImageView, movieTitleLabel)
        configureUIElements()
    }
    
    private func configureUIElements() {
        let standartPadding: CGFloat = 10
        movieImageView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.8)
            make.top.left.right.equalToSuperview()
        }
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom)
            make.left.equalToSuperview().offset(standartPadding)
            make.right.equalToSuperview().offset(-standartPadding)
            make.bottom.equalToSuperview()
        }
    }
}
