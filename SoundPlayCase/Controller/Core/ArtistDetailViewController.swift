//
//  ArtistDetailViewController.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/4/23.
//

import UIKit

class ArtistDetailViewController : UIViewController {
    
    var myCollectionView:UICollectionView?
    
    var viewModel: HomeViewModel = HomeViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureUI()
    }
}

extension ArtistDetailViewController {
    func setupUI() {
        let view = UIView()
        view.backgroundColor = .white
        

        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 150, height: UIScreen.main.bounds.height/2 - 50)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 5)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        myCollectionView?.collectionViewLayout = flowLayout
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)

        myCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ArtistDetailCell")
        myCollectionView?.backgroundColor = UIColor.white

        view.addSubview(myCollectionView ?? UICollectionView())
        
        self.view = view
    }
    
    func configureUI() {
        myCollectionView?.register(ArtistDetailCell.self, forCellWithReuseIdentifier: "ArtistDetailCell")
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
    }
}


extension ArtistDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistDetailCell", for: indexPath) as! ArtistDetailCell
        if let model = viewModel.getDataWithIndexpath(indexpath: indexPath){
            detailCell.configureCell(song: model)
        }
            return detailCell
    }
    
    
}


