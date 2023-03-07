//
//  ViewController.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/4/23.
//

import UIKit
import CoreData

class HomeViewController: BaseViewController<HomeViewModel> {
        
    private lazy var artistTableView: UITableView = {
        let tableView = UITableView.init()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 90.0
        tableView.isHidden = true
        tableView.isUserInteractionEnabled = true
        return tableView
    }()
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView.init()
        indicator.style = .large
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: Constants
    private let pageInfoTitleTopSpace: CGFloat = 10.0
    private let tableViewContentPadding: CGFloat = 8.0
    private let indicatorSize: CGFloat = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        configureUI()
        configureBindings()
        viewModel?.viewDidLoad()
    }
    
    private func setupUI() {
        showIndicator()
        
        view.addSubview(artistTableView)
        NSLayoutConstraint.activate([
            artistTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: tableViewContentPadding),
            artistTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -tableViewContentPadding),
            artistTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: tableViewContentPadding),
            artistTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: tableViewContentPadding)
        ])
    }
    
    private func configureUI(){
        artistTableView.register(SongfInfoCell.self, forCellReuseIdentifier: "cell")
        artistTableView.delegate = self
        artistTableView.dataSource = self
    }
    
    private func configureBindings() {
        viewModel?.onDataLoaded = {[weak self] in
            DispatchQueue.main.async {
                self?.artistTableView.reloadData()
                self?.hideIndicator()
                self?.artistTableView.isHidden = false
            }
        }
    }
    
    private func showIndicator() {
        view.addSubview(indicatorView)
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        indicatorView.startAnimating()
    }
    
    private func hideIndicator() {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
    }
    
    override func onDataChanged() {
        DispatchQueue.main.async {
            self.hideIndicator()
            self.artistTableView.isHidden = false
            self.artistTableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SongfInfoCell
        let model = fetchedResultsController.object(at: indexPath)
        cell.configureCell(song: model)
        cell.selectionStyle = .none
        cell.onClickedCell = {[weak self] song in
            print(song.trackId ?? 0)
        }
        return cell
    }
}


