//
//  FilmsDataSource.swift
//  StartWarsRemake
//
//  Created by Muñoz, Jesus Manuel on 13/3/21.
//

import Foundation
import Alamofire

protocol StartshipRepository {
    typealias Completion = ([StarshipModel]?, String?) -> Void
    
    func fetchStarships(for name: String, completion: @escaping Completion)
    func map(starships: Starships) -> [StarshipModel]
}

class StartshipDataSource: StartshipRepository {
    
    func fetchStarships(for name: String, completion: @escaping Completion) {
        let url = "https://swapi.dev/api/starships"
        
        let parameters: [String: String] = ["search": name]
        
        AF.request(url, parameters: parameters).validate().responseDecodable(of: Starships.self) { response in
            if let error = response.error {
                completion(nil, error.localizedDescription)
            } else {
                guard let starships = response.value else {
                    completion(nil, "Empty result")
                    return
                }
                completion(self.map(starships: starships), nil)
            }
        }
    }
    
    internal func map(starships: Starships) -> [StarshipModel] {
        var startshipModelList: [StarshipModel] = []
        for item in starships.all {
            startshipModelList.append(StarshipModel(starhip: item))
        }
        return startshipModelList
    }
}
