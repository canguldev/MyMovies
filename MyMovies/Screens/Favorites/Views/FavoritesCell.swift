//
//  FavoritesCell.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import UIKit

class FavoritesCell: UITableViewCell {

    //MARK: - Variables
    static let identifier = "FavoritesCell"
    var viewModel = FavoritesCellViewModel()
    
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
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Functions
    func setupCell(movie: MovieModel) {
        guard let moviePosterPath = movie.posterPath else { return }
        self.movieImageView.kf.setImage(with: viewModel.makeImageUrl(imageString: moviePosterPath))
        self.movieTitleLabel.text = movie.title
        self.movieDescriptionLabel.text = movie.overview
    }
    
    private func setupUI() {
        addSubviewsFromExt(movieImageView, movieTitleLabel, movieDescriptionLabel)
        configureUIElements()
    }
    
    private func configureUIElements() {
        let standartPadding: CGFloat = 10
        movieImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.3)
            make.top.equalToSuperview().offset(standartPadding)
            make.left.equalToSuperview().offset(standartPadding)
            make.bottom.equalToSuperview().offset(-standartPadding)
        }
        movieTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(standartPadding)
            make.left.equalTo(movieImageView.snp.right).offset(standartPadding)
            make.right.equalToSuperview().offset(-standartPadding)
        }
        movieDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom)
            make.left.equalTo(movieImageView.snp.right).offset(standartPadding)
            make.right.equalToSuperview().offset(-standartPadding)
            make.bottom.equalToSuperview().offset(-standartPadding)
        }
    }
}
