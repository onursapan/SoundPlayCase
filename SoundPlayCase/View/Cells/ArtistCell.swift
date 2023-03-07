//
//  ArtistsCell.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/7/23.
//

import Foundation
import UIKit

class ArtistCell: UICollectionViewCell{
    
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    private lazy var trackNameLabel: UILabel = {
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    private lazy var forwardButton: ForwardButton = {
        let button = ForwardButton.init()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.delegate = self
        button.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        return button
    }()
    
    private lazy var contentVStackView: UIStackView = {
        let stackView = UIStackView.init()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    var onClickedCell: ((SoundPlay)->())?
        
    private let contentVerticalPadding: CGFloat = 12.0
    private let contentHorizontalPadding: CGFloat = 16.0
    private let imageSize: CGFloat = 30.0
    
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
        
        
        addSubview(forwardButton)
        addSubview(contentVStackView)
        

        
        NSLayoutConstraint.activate([
            contentVStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentHorizontalPadding),
            contentVStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentVStackView.trailingAnchor.constraint(equalTo: forwardButton.leadingAnchor, constant: -contentHorizontalPadding)
        ])
        
        NSLayoutConstraint.activate([
            forwardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -contentHorizontalPadding),
            forwardButton.centerYAnchor.constraint(equalTo: contentVStackView.centerYAnchor)
            //forwardButton.widthAnchor.constraint(equalTo: forwardButton.heightAnchor)
        ])
        contentVStackView.addArrangedSubview(artistNameLabel)
        contentVStackView.addArrangedSubview(trackNameLabel)
        
        artistNameLabel.text = "asdsadasdasda"
        trackNameLabel.text = "asdsadasdasda"
    }
    
    public func configureCell(song: SoundPlay){
        self.song = song
        artistNameLabel.text = song.artistName
        trackNameLabel.text = song.trackName
    }
}

extension ArtistCell: ForwardButtonDelegate{
    func onClickToForward(button: ForwardButton) {
        guard let song = song else{
            return
        }
        onClickedCell?(song)
    }
}
