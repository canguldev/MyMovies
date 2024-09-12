//
//  HomeVC.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {

    //MARK: - Variables
    var viewModel = HomePageViewModel()
    var nowPlayingDataSource: [HomeCellViewModel] = []
    var popularDataSource: [HomeCellViewModel] = []
    var topRatedDataSource: [HomeCellViewModel] = []
    let sectionTitles: [String] = ["Now playing", "Popular", "Top rated"]
    
    //MARK: - UI Elements
    private lazy var moviesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewCell.self, forCellReuseIdentifier: CollectionViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        fetchMovies()
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
        viewModel.nowPlayingDataSource.bind { [weak self] movies in
            guard let movies = movies else { return }
            self?.nowPlayingDataSource = movies
            self?.reloadTableView()
        }
        viewModel.popularDataSource.bind { [weak self] movies in
            guard let movies = movies else { return }
            self?.popularDataSource = movies
            self?.reloadTableView()
        }
        viewModel.topRatedDataSource.bind { [weak self] movies in
            guard let movies = movies else { return }
            self?.topRatedDataSource = movies
            self?.reloadTableView()
        }
    }
    
    private func fetchMovies() {
        viewModel.fetchMovies()
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.moviesTableView.reloadData()
        }
    }
}

//MARK: - UITableViewDelegate
extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 10, y: header.bounds.origin.y, width: header.bounds.width, height: header.bounds.height)
        header.textLabel?.textColor = .label
        let sectionTitle = header.textLabel?.text
        let formattedTitle = sectionTitle?.capitalized(with: Locale.current)
        header.textLabel?.text = formattedTitle
    }
}

//MARK: - UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.headerTitle(stringList: sectionTitles, section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sectionsCount(stringList: sectionTitles)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = moviesTableView.dequeueReusableCell(withIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        switch indexPath.section {
        case TableViewSections.nowPlaying.rawValue:
            cell.setupCell(viewModel: nowPlayingDataSource)
        case TableViewSections.popular.rawValue:
            cell.setupCell(viewModel: popularDataSource)
        case TableViewSections.topRated.rawValue:
            cell.setupCell(viewModel: topRatedDataSource)
        default:
            break
        }
        return cell
    }
}

extension HomeVC: CollectionViewCellDelegate {
    func collectionViewCellDidTapCell(_ cell: CollectionViewCell, viewModel: MovieDetailViewModel) {
        let destinationVC = MovieDetailVC(viewModel: viewModel)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
