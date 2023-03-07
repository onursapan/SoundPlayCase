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
        imageView.image = UIImage.init(systemName: "arrowshape.turn.up.forward.fill")
        return imageView
    }()
    
    private let iconSize: CGFloat = 15.0
    
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
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        
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
        isUserInteractionEnabled = true
        addGestureRecognizer(recognizer)
    }
    
    @objc
    func onClickedContent(){
        delegate?.onClickToForward(button: self)
    }
}
