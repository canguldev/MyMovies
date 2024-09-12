//
//  MovieDetailVC.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import UIKit
import Kingfisher

class MovieDetailVC: UIViewController {

    //MARK: - Variables
    var viewModel: MovieDetailViewModel
    
    //MARK: - UI Elements
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var movieVoteLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var movieDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textAlignment = .justified
        textView.isEditable = false
        return textView
    }()
    
    private lazy var movieDownloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add to favorites", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    //MARK: - Lifecycle
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setUIElementsValue()
    }
    
    //MARK: - Helper Functions
    private func setUIElementsValue() {
        movieTitleLabel.text = viewModel.title
        movieImageView.kf.setImage(with: viewModel.movieImage)
        movieVoteLabel.text = viewModel.voteLabel
        movieDescriptionTextView.text = viewModel.description
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Movie Detail"
        configureUIElements()
    }
    
    private func configureUIElements() {
        view.addSubviewsFromExt(movieTitleLabel, movieImageView, movieVoteLabel, movieDescriptionTextView, movieDownloadButton)
        let standartPadding: CGFloat = 10
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(standartPadding)
            make.left.equalToSuperview().offset(standartPadding)
            make.right.equalToSuperview().offset(-standartPadding)
        }
        movieImageView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.25)
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(standartPadding)
            make.left.equalToSuperview().offset(standartPadding)
            make.right.equalToSuperview().offset(-standartPadding)
        }
        movieVoteLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(standartPadding)
            make.left.equalToSuperview().offset(standartPadding)
            make.right.equalToSuperview().offset(-standartPadding)
        }
        movieDescriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(movieVoteLabel.snp.bottom).offset(standartPadding)
            make.left.equalToSuperview().offset(standartPadding)
            make.right.equalToSuperview().offset(-standartPadding)
            make.bottom.equalTo(movieDownloadButton.snp.top).offset(-standartPadding)
        }
        movieDownloadButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(standartPadding)
            make.right.equalToSuperview().offset(-standartPadding)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-standartPadding)
        }
    }
}
