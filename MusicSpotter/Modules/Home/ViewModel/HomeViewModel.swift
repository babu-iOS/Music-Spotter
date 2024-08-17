//
//  HomeViewModel.swift
//  MusicSpotter
//
//  Created by IOS-Babu on 10/05/24.
//

import Foundation

class HomeViewModel {
    var model: RootClass?
    
    func fetchData(searchText:String,onSuccess: @escaping (String,Int) -> (), onFailure: @escaping (String) -> ()){
        
        let apiUrl = "https://itunes.apple.com/search?term=\(searchText)"
        print(apiUrl)
        APIManager.shared.makeRequest(url: apiUrl) { [weak self]  success, message, json in
            if success {
                self?.model = RootClass(fromJson: json)
                onSuccess(json["message"].stringValue,json["resultCount"].intValue)
            }else{
                onFailure(json["message"].stringValue)
            }
        }
    }
}
