//
//  HomeViewModel.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/6/23.
//

import Foundation
import CoreData
import UIKit

class HomeViewModel: BaseViewModel{
    
    var onDataLoaded: (() -> Void)?
    var onErrorReceived: ( (Error) -> Void)?
    
    var result: Artist?
    
    var pageLimit: Int = 20
    var page: Int = 1
        
    var requiredCount: Int {
        pageLimit * page
    }
        
    func viewDidLoad(){
        getData()
    }
    
    func getData(){
        dataProvider.fetchSounds(pageLimit: requiredCount, errorHandler: {[weak self] _ in
        })
    }
}
