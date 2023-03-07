//
//  HomeViewModel.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/6/23.
//

import Foundation

class HomeViewModel{
    
    var onDataLoaded: (() -> Void)?
    var onErrorReceived: ( (Error) -> Void)?
    
    var pageLimit: Int = 20
    var offset: Int = 0
    
    var result: Artist?
    
    var resultList: [Result] = .init()
    
    func viewDidLoad(){
        fetchData()
    }
    
    func fetchData(shouldGetNextPage: Bool = false){
        offset = shouldGetNextPage ? offset + 1 : offset
        
        let url = URL(string: "https://itunes.apple.com/search?term=jack+johnson&limit=\(pageLimit)&offset=\(offset)")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                self.onErrorReceived?(error!)
                print("Error: \(error?.localizedDescription ?? "Unknow Error")")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(Artist.self, from: data)
                self.result = response
                self.resultList += response.results ?? []
                self.onDataLoaded?()
            } catch {
                self.onErrorReceived?(error)
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func getDataWithIndexpath(indexpath: IndexPath) -> Result? {
        if result?.results?.count ?? 0 >= indexpath.row, let model = result?.results?[indexpath.row]{
            return model
        }
        return nil
    }
}
