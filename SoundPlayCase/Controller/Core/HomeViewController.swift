//
//  ViewController.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/4/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel = HomeViewModel.init()
    
    private lazy var pageTitleLabel: UILabel = {
        var label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistTableView: UITableView = UITableView.init()
    
    
    // MARK: Constants
    private let pageInfoTitleTopSpace: CGFloat = 10.0
    private let tableViewContentPadding: CGFloat = 8.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.viewDidLoad()
    }
    
    private func setupUI() {
        view.addSubview(pageTitleLabel)
        
        NSLayoutConstraint.activate([
            pageTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: pageInfoTitleTopSpace)
        ])
        
        view.addSubview(artistTableView)
        NSLayoutConstraint.activate([
            artistTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: tableViewContentPadding),
            artistTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: tableViewContentPadding),
            artistTableView.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: tableViewContentPadding),
            artistTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: tableViewContentPadding)
        ])
    }
}
