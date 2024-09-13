//
//  FavoritesVC.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import UIKit
import SnapKit

class FavoritesVC: UIViewController {

    //MARK: - Variables
    private var movies: [MovieModel] = [MovieModel]()
    var viewModel = FavoritesViewModel()
    
    //MARK: - UI Elements
    private lazy var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovieFromDatabase()
    }
    
    //MARK: - Helper Functions
    private func setupUI() {
        view.backgroundColor = .systemBackground
        configureUIElements()
    }

    private func configureUIElements() {
        view.addSubview(moviesTableView)
        moviesTableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bindViewModel() {
        viewModel.movieModelDataSource.bind { [weak self] result in
            guard let result = result else { return }
            self?.movies = result
            self?.reloadTableView()
        }
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.moviesTableView.reloadData()
        }
    }
    
    private func fetchMovieFromDatabase() {
        viewModel.fetchMovieFromDatabase()
    }
}

extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "Remove") { _, _, _ in
            self.viewModel.deleteMovieFromDatabase(model: self.movies[indexPath.row])
            self.movies.remove(at: indexPath.row)
            self.moviesTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
    
}

extension FavoritesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsCount(movies: movies)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = moviesTableView.dequeueReusableCell(withIdentifier: FavoritesCell.identifier, for: indexPath) as? FavoritesCell else {
            return UITableViewCell()
        }
        let movie = movies[indexPath.row]
        cell.setupCell(movie: movie)
        return cell
    }
    
}
