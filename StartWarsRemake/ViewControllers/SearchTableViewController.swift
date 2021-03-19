//
//  SearchTableViewController.swift
//  StartWarsRemake
//
//  Created by Muñoz, Jesus Manuel on 13/3/21.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    private var _searchCriteria: SearchCriteria = .Films
    var searchCriteria: SearchCriteria? {
        get {
            return _searchCriteria
        }
        set {
            if let value = newValue {
                _searchCriteria = value
                presenter.search(by: _searchCriteria)
                searchBar.setEnabled(enable: _searchCriteria == .Starships)
            }
        }
    }
    
    var items: [Displayable] = []
    var selectedItem: Displayable? = nil
    lazy var presenter: SearchPresenterProtocol = SearchPresenter(view: self)
    
    private let cellSelectedSegueId = "DetailSegue"

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
      selectedItem = items[indexPath.row]
      return indexPath
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! SearchTableViewCell
        cell.bind(item: items[indexPath.row])
        return cell
    }
    
    
    // MARK: - Searchbar delegates
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let starshipName = searchBar.text else { return }
        presenter.search(for: starshipName, by: _searchCriteria)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case cellSelectedSegueId:
            guard let destinationVC = segue.destination as? DetailViewController else {
                return
            }
            destinationVC.itemToDisplay = selectedItem
            return
        default:
            return
        }
    }
}

// MARK: - View Protocol
extension SearchTableViewController: SearchViewProtocol {
    func showLoading() {
        showSpinner(onView: self.view)
    }
    
    func hideLoading() {
        removeSpinner()
    }
    
    func onResult(items: [Displayable]) {
        self.items = items
        tableView.reloadData()
    }
    
    func onError(errorMessage: String) {
        showErrorAlert(errorMessage: errorMessage)
    }
}
