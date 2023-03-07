//
//  SongfInfoCell.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/7/23.
//

import Foundation
import UIKit

class NavigationBar: UIView{
    
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var artWorkImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var contentVStackView: UIStackView = {
        let stackView = UIStackView.init()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
        
    private let contentVerticalPadding: CGFloat = 12.0
    private let contentHorizontalPadding: CGFloat = 8.0
    private let imageSize: CGFloat = 30.0
    private let spacingBetweenImageAndContent: CGFloat = 5.0

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        
        addSubview(artWorkImageView)
        NSLayoutConstraint.activate([
            artWorkImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentHorizontalPadding),
            artWorkImageView.topAnchor.constraint(equalTo: topAnchor, constant: contentVerticalPadding),
            artWorkImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -contentVerticalPadding),
            artWorkImageView.widthAnchor.constraint(equalTo: artWorkImageView.heightAnchor)
        ])
        
        addSubview(contentVStackView)
        NSLayoutConstraint.activate([
            contentVStackView.leadingAnchor.constraint(equalTo: artWorkImageView.trailingAnchor, constant: spacingBetweenImageAndContent),
            contentVStackView.topAnchor.constraint(equalTo: topAnchor, constant: contentVerticalPadding),
            contentVStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -contentVerticalPadding),
            contentVStackView.trailingAnchor.constraint(equalTo: forwardButton.leadingAnchor, constant: -contentHorizontalPadding)
        ])
        
        contentVStackView.addArrangedSubview(artistNameLabel)
    }
}
