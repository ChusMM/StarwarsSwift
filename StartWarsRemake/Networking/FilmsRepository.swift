//
//  FilmsRepository.swift
//  StartWarsRemake
//
//  Created by Muñoz, Jesus Manuel on 19/3/21.
//

import Foundation
import Alamofire

protocol FilmRepository {
    typealias Completion = ([FilmModel]?, String?) -> Void
    
    func fetchFilms(completion: @escaping Completion)
    func map(films: Films) -> [FilmModel]
}

class FilmDataSource: FilmRepository {
    
    func fetchFilms(completion: @escaping Completion) {
        let url = "https://swapi.dev/api/films"
                
        AF.request(url).validate().responseDecodable(of: Films.self) { response in
            if let error = response.error {
                completion(nil, error.localizedDescription)
            } else {
                guard let films = response.value else {
                    completion(nil, "Empty result")
                    return
                }
                completion(self.map(films: films), nil)
            }
        }
    }
    
    internal func map(films: Films) -> [FilmModel] {
        var filmModelList: [FilmModel] = []
        for item in films.all {
            filmModelList.append(FilmModel(film: item))
        }
        return filmModelList
    }
}
