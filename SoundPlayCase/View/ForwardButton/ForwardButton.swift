//
//  ForwardButton.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/7/23.
//

import Foundation
import UIKit

class ForwardButton: UIView{
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let iconSize: CGFloat = 50.0
    
    weak var delegate: ForwardButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: iconSize),
            iconImageView.widthAnchor.constraint(equalToConstant: iconSize)
        ])
    }
    
    private func setupRecognizers(){
        let recognizer = UITapGestureRecognizer.init(target: self, action: #selector(onClickedContent))
        addGestureRecognizer(recognizer)
    }
    
    @objc
    func onClickedContent(){
        delegate?.onClickToForward(button: self)
    }
}
