//
//  ArtistViewController.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/4/23.
//

import UIKit

class ArtistViewController : UIViewController {
    
    var myCollectionView:UICollectionView?
    
    var viewModel: HomeViewModel = HomeViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureUI()
    }
}

extension ArtistViewController {
    func setupUI() {
        let view = UIView()
        view.backgroundColor = .white
        

        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/2 - 16 , height: UIScreen.main.bounds.height/4)
        flowLayout.sectionInset = UIEdgeInsets(top: 50, left: 10, bottom: 0, right: 10)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 1.0
        flowLayout.minimumLineSpacing = 16.0
        myCollectionView?.collectionViewLayout = flowLayout
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)

        myCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ArtistCell")
        myCollectionView?.backgroundColor = UIColor.white

        view.addSubview(myCollectionView ?? UICollectionView())
        
        self.view = view
    }
    
    func configureUI() {
        myCollectionView?.register(ArtistCell.self, forCellWithReuseIdentifier: "ArtistCell")
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
    }
}


extension ArtistViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistCell", for: indexPath) as! ArtistCell
        if let model = viewModel.getDataWithIndexpath(indexpath: indexPath){
            detailCell.configureCell(song: model)
        }
            return detailCell
    }
    
    
}

