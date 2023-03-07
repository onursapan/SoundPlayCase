//
//  BaseViewModel.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/8/23.
//

import Foundation
import UIKit

class BaseViewModel{
    var dataProvider: DataProvider = {
        DataProvider(persistentContainer: (UIApplication.shared.delegate as! AppDelegate).persistentContainer)
    }()
}
