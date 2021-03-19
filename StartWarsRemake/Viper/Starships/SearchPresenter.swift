//
//  FilmsPresenter.swift
//  StartWarsRemake
//
//  Created by Muñoz, Jesus Manuel on 13/3/21.
//

import Foundation

enum SearchCriteria {
    case Films
    case Starships
}

protocol SearchViewProtocol {
    func showLoading()
    func hideLoading()
    func onResult(items: [Displayable])
    func onError(errorMessage: String)
}

typealias CompletionError = (String) -> Void

protocol SearchPresenterProtocol: class {
    var starshipInteractor: StarshipInteractorProtocol { get }
    var filmInteractor: FilmsInteractor { get }
    var starshipCompletionSuccess: StarshipCompletionSuccess { get }
    var filmCompletionSuccess: FilmCompletionSuccess { get }
    var completionError: CompletionError { get }
    
    func search(for filter: String, by criteria: SearchCriteria)
}

extension SearchPresenterProtocol {
    func search(by criteria: SearchCriteria) {
        search(for: "", by: criteria)
    }
}

extension StarshipModel: Displayable {
    var titleLabelText: String {
        name
    }
    
    var subtitleLabelText: String {
        model
    }
    
    var item1: (label: String, value: String) {
        ("MANUFACTURER", manufacturer)
    }
    
    var item2: (label: String, value: String) {
        ("CLASS", starshipClass)
    }
    
    var item3: (label: String, value: String) {
        ("HYPERDRIVE RATING", hyperdriveRating)
    }
    
    var listTitle: String {
        "FILMS"
    }
    
    var listItems: [String] {
        films
    }
}

extension FilmModel: Displayable {
    var titleLabelText: String {
        title
    }
  
    var subtitleLabelText: String {
        "Episode \(String(id))"
    }

    var item1: (label: String, value: String) {
        ("DIRECTOR", director)
    }

    var item2: (label: String, value: String) {
        ("PRODUCER", producer)
    }

    var item3: (label: String, value: String) {
        ("RELEASE DATE", releaseDate)
    }

    var listTitle: String {
        "STARSHIPS"
    }

    var listItems: [String] {
        starships
    }
}


class SearchPresenter: SearchPresenterProtocol {
    internal let starshipInteractor: StarshipInteractorProtocol
    internal let filmInteractor: FilmsInteractor
    
    lazy internal var starshipCompletionSuccess: StarshipCompletionSuccess = { model in
        self.onSuccess(displayable: model)
    }
    
    lazy internal var filmCompletionSuccess: FilmCompletionSuccess = { model in
        self.onSuccess(displayable: model)
    }
    
    lazy internal var completionError: CompletionError = onError
    
    private let view: SearchViewProtocol
    
    init(view: SearchViewProtocol) {
        starshipInteractor = StarshipInteractor()
        filmInteractor = FilmsInteractor()
        self.view = view
    }
    
    func search(for filter: String = "", by criteria: SearchCriteria) {
        view.showLoading()
        switch criteria {
        case .Films:
            filmInteractor.fetchFilms(onSucess: filmCompletionSuccess, onError: completionError)
        case .Starships:
            starshipInteractor.fetchStarships(filter: filter, onSucess: starshipCompletionSuccess, onError: completionError)
        }
    }
    
    private func onSuccess(displayable: [Displayable]) {
        view.hideLoading()
        view.onResult(items: displayable)
    }
    
    private func onError(errorMessage: String) {
        view.hideLoading()
        view.onError(errorMessage: errorMessage)
    }
}
