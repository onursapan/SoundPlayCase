//
//  ArtistDetailCell.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/7/23.
//

import Foundation
import UIKit
import Kingfisher

class ArtistDetailCell: UICollectionViewCell{
    
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trackNameLabel: UILabel = {
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var releaseTrackDateLabel: UILabel = {
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trackPriceLabel: UILabel = {
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var artWorkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = .orange
        return imageView
    }()
    
    private lazy var forwardButton: ForwardButton = {
        let button = ForwardButton.init()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.delegate = self
        button.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "minus.circle"), for: .normal)
        button.backgroundColor = UIColor.darkGray
        return button
    }()
    
    private lazy var contentVStackView: UIStackView = {
        let stackView = UIStackView.init()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    var onClickedCell: ((SoundPlay)->())?
        
    private let contentVerticalPadding: CGFloat = 12.0
    private let contentHorizontalPadding: CGFloat = 8.0
    private let spacingBetweenImageAndContent: CGFloat = 5.0
    
    var song: SoundPlay?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI(){
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        

        addSubview(deleteButton)
        addSubview(artWorkImageView)
        addSubview(forwardButton)
        addSubview(contentVStackView)
        NSLayoutConstraint.activate([
        
            deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: contentVerticalPadding),
            deleteButton.bottomAnchor.constraint(equalTo: artWorkImageView.topAnchor, constant: -contentVerticalPadding),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -contentHorizontalPadding),
            deleteButton.widthAnchor.constraint(equalTo: deleteButton.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            artWorkImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            artWorkImageView.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: contentVerticalPadding),
            artWorkImageView.bottomAnchor.constraint(equalTo: contentVStackView.topAnchor, constant: -contentVerticalPadding),
            artWorkImageView.widthAnchor.constraint(equalTo: artWorkImageView.heightAnchor)
        ])
        

        
        NSLayoutConstraint.activate([
            forwardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -contentHorizontalPadding),
            forwardButton.topAnchor.constraint(equalTo: contentVStackView.bottomAnchor, constant: contentVerticalPadding),
            forwardButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -contentVerticalPadding)
        ])
        

        NSLayoutConstraint.activate([
            contentVStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacingBetweenImageAndContent),
            contentVStackView.topAnchor.constraint(equalTo: artWorkImageView.bottomAnchor, constant: contentVerticalPadding),
            contentVStackView.bottomAnchor.constraint(equalTo: forwardButton.topAnchor, constant: -contentVerticalPadding),
            contentVStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -contentHorizontalPadding)
        ])
        
        contentVStackView.addArrangedSubview(artistNameLabel)
        contentVStackView.addArrangedSubview(trackNameLabel)
        contentVStackView.addArrangedSubview(releaseTrackDateLabel)
        contentVStackView.addArrangedSubview(trackPriceLabel)
    }
    
    public func configureCell(song: SoundPlay){
        self.song = song
        artistNameLabel.text = song.artistName
        trackNameLabel.text = song.trackName
        releaseTrackDateLabel.text = song.releaseDate
//        trackPriceLabel.text = String(describing: song.trackPrice)
        if let urlStr = song.albumImage, let url = URL.init(string: urlStr){
            artWorkImageView.kf.setImage(with: url)
        }
    }
}


extension ArtistDetailCell: ForwardButtonDelegate{
    func onClickToForward(button: ForwardButton) {
        guard let song = song else{
            return
        }
        onClickedCell?(song)
    }
}
