//
//  ResultViewController.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/4/23.
//

import UIKit

class ResultViewController: BaseViewController<HomeViewModel> {
        
    private lazy var trackCountResultLabel: UILabel = {
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    private lazy var artistTableView: UITableView = {
        let tableView = UITableView.init()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
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
    private let resultLabelTopSpace: CGFloat = 16.0
    private let indicatorSize: CGFloat = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        configureUI()
        viewModel?.viewDidLoad()
    }
    
    private func setupUI() {
        showIndicator()
        
        view.addSubview(trackCountResultLabel)
        view.addSubview(artistTableView)
        
        
        NSLayoutConstraint.activate([
            trackCountResultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: resultLabelTopSpace),
            
            
            artistTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: tableViewContentPadding),
            artistTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -tableViewContentPadding),
            artistTableView.topAnchor.constraint(equalTo: trackCountResultLabel.bottomAnchor, constant: tableViewContentPadding),
            artistTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: tableViewContentPadding)
        ])
    }
    
    private func configureUI(){
        artistTableView.register(ResultCell.self, forCellReuseIdentifier: "cell")
        artistTableView.delegate = self
        artistTableView.dataSource = self
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
            let result = self.viewModel?.result?.results?.count ?? 0
            self.trackCountResultLabel.text = "\(result) adet sonuç bulundu."
        }
        
//        DispatchQueue.main.async {
//            self.hideIndicator()
//            self.artistTableView.reloadData()
//            self.artistTableView.isHidden = false
//            if let result =  {
//                self.trackCountResultLabel.text = "\(result) adet sonuç bulundu."
//            } else {
//
//            }
//        }
    }
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultCell
        let model = fetchedResultsController.object(at: indexPath)
        cell.configureCell(song: model)
        cell.selectionStyle = .none
        cell.onClickedCell = {[weak self] song in
            print(song.artistName)
        }
        return cell
    }
}
