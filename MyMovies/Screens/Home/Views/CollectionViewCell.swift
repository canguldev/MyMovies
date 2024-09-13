//
//  CollectionViewCell.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import UIKit
import SnapKit

protocol CollectionViewCellDelegate: AnyObject {
    func collectionViewCellDidTapCell(_ cell: CollectionViewCell, viewModel: MovieDetailViewModel)
}

class CollectionViewCell: UITableViewCell {
    
    //MARK: - Variables
    static let identifier = "CollectionViewCell"
    var viewModel = CollectionViewCellViewModel()
    let layout = UICollectionViewFlowLayout()
    var cellDataSource: [HomeCellViewModel] = []
    weak var delegate: CollectionViewCellDelegate?
    
    //MARK: - UI Elements
    private lazy var moviesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
        collectionView.clipsToBounds = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    //MARK: - Lifecycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Functions
    private func setupUI(){
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(moviesCollectionView)
        configureUIElements()
    }
    
    private func configureUIElements() {
        let standartPadding: CGFloat = 10
        moviesCollectionView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(standartPadding)
        }
    }
    
    func setupCell(viewModel: [HomeCellViewModel]) {
        self.cellDataSource = viewModel
        reloadCollectionView()
    }
    
    func reloadCollectionView() {
        self.moviesCollectionView.reloadData()
    }
    
    //MARK: - @Actions
    private func addToFavorite(indexPath: IndexPath) {
        guard let movie = cellDataSource[indexPath.row].movie else { return }
        viewModel.saveMovieToDatabase(movie: movie)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.width * 0.4
        let itemHeight = collectionView.frame.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

//MARK: - UICollectionViewDelegate
extension CollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = cellDataSource[indexPath.row].movie else { return }
        delegate?.collectionViewCellDidTapCell(self, viewModel: MovieDetailViewModel(movie: movie))
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        guard let indexPath = indexPaths.first else { return nil }
        let config = UIContextMenuConfiguration(actionProvider:  { [weak self] _ in
            let favoriteAction = UIAction(title: "Add to favorites", image: UIImage(systemName: "heart")) { _ in
                self?.addToFavorite(indexPath: indexPath)
            }
            return UIMenu(options: .displayInline, children: [favoriteAction])
        })
        return config
    }
}

//MARK: - UICollectionViewDataSource
extension CollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsCount(cellDataSource: cellDataSource)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell else {
            return UICollectionViewCell()
        }
        let cellViewModel = cellDataSource[indexPath.row]
        cell.setupCell(viewModel: cellViewModel)
        return cell
    }
}
