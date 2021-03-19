//
//  FilmsInteractor.swift
//  StartWarsRemake
//
//  Created by Muñoz, Jesus Manuel on 13/3/21.
//

import Foundation

struct StarshipModel: Decodable {
    var name: String
    var model: String
    var manufacturer: String
    var cost: String
    var length: String
    var maximumSpeed: String
    var crewTotal: String
    var passengerTotal: String
    var cargoCapacity: String
    var consumables: String
    var hyperdriveRating: String
    var starshipClass: String
    var films: [String]
    
    init(starhip: Starship) {
        name = starhip.name
        model = starhip.model
        manufacturer = starhip.manufacturer
        cost = starhip.cost
        length = starhip.length
        maximumSpeed = starhip.maximumSpeed
        crewTotal = starhip.crewTotal
        passengerTotal = starhip.passengerTotal
        cargoCapacity = starhip.cargoCapacity
        consumables = starhip.consumables
        hyperdriveRating = starhip.hyperdriveRating
        starshipClass = starhip.starshipClass
        films = starhip.films
    }
}

typealias StarshipCompletionSuccess = ([StarshipModel]) -> Void

protocol StarshipInteractorProtocol {
    func fetchStarships(filter: String, onSucess: @escaping StarshipCompletionSuccess, onError: @escaping CompletionError)
}

class StarshipInteractor: StarshipInteractorProtocol {
    private let starshipRepository = StartshipDataSource()
    
    func fetchStarships(filter: String, onSucess: @escaping StarshipCompletionSuccess, onError: @escaping CompletionError) {
        self.starshipRepository.fetchStarships(for: filter) { model, error in
            if let errorMessage = error {
                onError(errorMessage)
            }
            
            guard let starships = model else {
                onError("Empty result")
                return
            }
            onSucess(starships)
        }
    }
}
