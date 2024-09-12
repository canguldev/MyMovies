//
//  ComingSoonVC.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import UIKit
import SnapKit

class ComingSoonVC: UIViewController {

    //MARK: - Variables
    let layout = UICollectionViewFlowLayout()
    var viewModel = ComingSoonViewModel()
    var cellDataSource: [ComingSoonCellViewModel] = []
    
    //MARK: - UI Elements
    private lazy var moviesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collectionView.register(ComingSoonCell.self, forCellWithReuseIdentifier: ComingSoonCell.identifier)
        collectionView.clipsToBounds = true
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        fetchMovies()
    }
    
    //MARK: - Helper Functions
    private func setupUI() {
        view.addSubview(moviesCollectionView)
        let standartPadding: CGFloat = 10
        moviesCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(standartPadding)
            make.right.equalToSuperview().offset(-standartPadding)
        }
    }
    
    func bindViewModel() {
        viewModel.cellDataSource.bind { [weak self] movies in
            guard let movies = movies else { return }
            self?.cellDataSource = movies
            self?.reloadCollectionView()
        }
    }
    
    private func fetchMovies() {
        viewModel.fetchComingSoonMovies()
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.moviesCollectionView.reloadData()
        }
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ComingSoonVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.width * 0.48
        let itemHeight = collectionView.frame.height / 2.5
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

//MARK: - UICollectionViewDelegate
extension ComingSoonVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedMovie = viewModel.getSelectedMovie(index: indexPath.row) else { return }
        let detailViewModel = MovieDetailViewModel(movie: selectedMovie)
        let destinationVC = MovieDetailVC(viewModel: detailViewModel)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension ComingSoonVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: ComingSoonCell.identifier, for: indexPath) as? ComingSoonCell else {
            return UICollectionViewCell()
        }
        let cellViewModel = self.cellDataSource[indexPath.row]
        cell.setupCell(viewModel: cellViewModel)
        return cell
    }
}
