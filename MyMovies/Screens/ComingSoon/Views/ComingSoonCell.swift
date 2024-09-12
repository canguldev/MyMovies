//
//  ComingSoonCell.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import UIKit
import SnapKit
import Kingfisher

class ComingSoonCell: UICollectionViewCell {
    
    //MARK: - Variables
    static let identifier = "ComingSoonCell"
    
    //MARK: - UI Elements
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "deadpool")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
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
    func setupCell(viewModel: ComingSoonCellViewModel) {
        self.movieImageView.kf.setImage(with: viewModel.imageURL)
    }
    
    private func setupUI() {
        addSubview(movieImageView)
        movieImageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
