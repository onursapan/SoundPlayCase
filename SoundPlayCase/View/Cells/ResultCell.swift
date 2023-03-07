//
//  ResultCell.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/7/23.
//

import Foundation
import UIKit
import Kingfisher

class ResultCell: UITableViewCell{
    
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
    
    private lazy var forwardButton: ForwardButton = {
        let button = ForwardButton.init()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.delegate = self
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
    private let imageSize: CGFloat = 30.0
    
    var song: SoundPlay?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        
        NSLayoutConstraint.activate([
            forwardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -contentHorizontalPadding),
            forwardButton.topAnchor.constraint(equalTo: topAnchor, constant: contentVerticalPadding),
            forwardButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -contentVerticalPadding),
            forwardButton.widthAnchor.constraint(equalTo: forwardButton.heightAnchor)
        ])
        
        addSubview(contentVStackView)
        NSLayoutConstraint.activate([
            contentVStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentHorizontalPadding),
            contentVStackView.topAnchor.constraint(equalTo: topAnchor, constant: contentVerticalPadding),
            contentVStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -contentVerticalPadding),
            contentVStackView.trailingAnchor.constraint(equalTo: forwardButton.leadingAnchor, constant: -contentHorizontalPadding)
        ])
        
        contentVStackView.addArrangedSubview(artistNameLabel)
        contentVStackView.addArrangedSubview(trackNameLabel)
    }
    
    public func configureCell(song: SoundPlay){
        self.song = song
        artistNameLabel.text = song.artistName
        trackNameLabel.text = song.trackName
    }
}


extension ResultCell: ForwardButtonDelegate{
    func onClickToForward(button: ForwardButton) {
        guard let song = song else{
            return
        }
        onClickedCell?(song)
    }
}
