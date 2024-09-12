//
//  SearchVC.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import UIKit
import SnapKit

class SearchVC: UIViewController {
    
    //MARK: - Variables
    var viewModel = SearchViewModel()
    var movieDataSource: [SearchCellViewModel] = []
    
    //MARK: - UI Elements
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: SearchResultsVC())
        searchController.searchResultsUpdater = self
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = "Search..."
        return searchController
    }()
    
    private lazy var searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "searchImage")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .label
        return imageView
    }()
    
    private lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.text = "Search for your favorite movies 👀"
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
     
    //MARK: - Helper Functions
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
        navigationItem.searchController = searchController
        view.addSubviewsFromExt(searchImageView, searchLabel)
        configurationUIElements()
    }
    
    private func configurationUIElements() {
        searchImageView.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.center.equalToSuperview()
        }
        searchLabel.snp.makeConstraints { make in
            make.top.equalTo(searchImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        viewModel.movieDataSource.bind { [weak self] movies in
            guard let movies = movies else { return }
            self?.movieDataSource = movies
        }
    }
}

//MARK: - UISearchResultsUpdating
extension SearchVC: UISearchResultsUpdating, SearchResultsVCDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty, query.trimmingCharacters(in: .whitespaces).count >= 3, let resultsController = searchController.searchResultsController as? SearchResultsVC else { return }
        viewModel.searchMovies(query: query)
        resultsController.delegate = self
        resultsController.movieDataSource = movieDataSource
        resultsController.moviesCollectionView.reloadData()
    }
    
    func searchResultsVCDidTapItem(viewModel: MovieDetailViewModel) {
        let destinationVC = MovieDetailVC(viewModel: viewModel)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
