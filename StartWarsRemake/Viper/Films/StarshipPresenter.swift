//
//  FilmsPresenter.swift
//  StartWarsRemake
//
//  Created by Muñoz, Jesus Manuel on 13/3/21.
//

import Foundation

protocol StarshipViewProtocol {
    func showLoading()
    func hideLoading()
    func onResult(items: [Displayable])
    func onError(errorMessage: String)
}

protocol StarshipPresenterProtocol: class {
    var interactor: StarshipInteractorProtocol { get }
    var completionSuccess: StarshipCompletionSuccess { get }
    var completionError: StarshipCompletionError { get }
    
    func searchStarships(for filter: String)
}

extension StarshipPresenterProtocol {
    func searchStarships() {
        searchStarships(for: "")
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

class StarshipPresenter: StarshipPresenterProtocol {
    internal let interactor: StarshipInteractorProtocol
    lazy internal var completionSuccess: StarshipCompletionSuccess = onSuccess
    lazy internal var completionError: StarshipCompletionError = onError
    
    private let view: StarshipViewProtocol
    
    init(view: StarshipViewProtocol) {
        interactor = StarshipInteractor()
        self.view = view
    }
    
    func searchStarships(for filter: String = "") {
        interactor.fetchStarships(filter: filter, onSucess: completionSuccess, onError: completionError)
    }
    
    private func onSuccess(model: [StarshipModel]) {
        view.hideLoading()
        view.onResult(items: model)
    }
    
    private func onError(errorMessage: String) {
        view.hideLoading()
        view.onError(errorMessage: errorMessage)
    }
}
