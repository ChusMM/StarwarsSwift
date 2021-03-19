//
//  FilmInteractor.swift
//  StartWarsRemake
//
//  Created by Muñoz, Jesus Manuel on 19/3/21.
//

import Foundation

struct FilmModel: Decodable {
    let id: Int
    let title: String
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    let starships: [String]
    
    init(film: Film) {
        id = film.id
        title = film.title
        openingCrawl = film.openingCrawl
        director = film.director
        producer = film.producer
        releaseDate = film.releaseDate
        starships = film.starships
    }
}

typealias FilmCompletionSuccess = ([FilmModel]) -> Void

protocol FilmsInteractorProtocol {
    func fetchFilms(onSucess: @escaping FilmCompletionSuccess, onError: @escaping CompletionError)
}

class FilmsInteractor: FilmsInteractorProtocol {
    var filmRespository = FilmDataSource()
    
    func fetchFilms(onSucess: @escaping FilmCompletionSuccess, onError: @escaping CompletionError) {
        filmRespository.fetchFilms() { model, error in
            if let errorMessage = error {
                onError(errorMessage)
            }
            
            guard let films = model else {
                onError("Empty result")
                return
            }
            onSucess(films)
        }
    }
}
