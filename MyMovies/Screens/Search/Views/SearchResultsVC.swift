//
//  SearchResultsVC.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import UIKit

protocol SearchResultsVCDelegate: AnyObject {
    func searchResultsVCDidTapItem(viewModel: MovieDetailViewModel)
}

class SearchResultsVC: UIViewController {

    //MARK: - Variables
    let layout = UICollectionViewFlowLayout()
    var movieDataSource: [SearchCellViewModel] = []
    weak var delegate: SearchResultsVCDelegate?
    
    //MARK: - UI Elements
    lazy var moviesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
        collectionView.clipsToBounds = true
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Helper Functions
    private func setupUI() {
        view.backgroundColor = .systemBackground
        configureUIElements()
    }
    
    private func configureUIElements() {
        view.addSubview(moviesCollectionView)
        let standartPadding: CGFloat = 10
        moviesCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(standartPadding)
            make.right.equalToSuperview().offset(-standartPadding)
        }
    }
}

extension SearchResultsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.width * 0.48
        let itemHeight = collectionView.frame.height / 2
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

//MARK: - UITableViewDelegate
extension SearchResultsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = self.movieDataSource[indexPath.row].movie else { return }
        delegate?.searchResultsVCDidTapItem(viewModel: MovieDetailViewModel(movie: movie))
    }
}

//MARK: - UITableViewDataSource
extension SearchResultsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else {
            return UICollectionViewCell()
        }
        let cellViewModel = movieDataSource[indexPath.row]
        cell.setupCell(viewModel: cellViewModel)
        return cell
    }
}
