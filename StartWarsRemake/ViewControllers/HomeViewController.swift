//
//  HomeViewController.swift
//  StartWarsRemake
//
//  Created by Muñoz, Jesus Manuel on 19/3/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var selector: UISegmentedControl!
    
    private let tableViewSegue = "TableViewSegue"
    
    private var searhTableViewController: SearchTableViewController?
    private let criterias: [SearchCriteria] = [.Starships, .Films]

    override func viewDidLoad() {
        super.viewDidLoad()
        selector.selectedSegmentIndex = 0
        selector.sendActions(for: UIControl.Event.valueChanged)
    }
    
    
    @IBAction func onSegmentedChanged(_ sender: UISegmentedControl) {
        self.searhTableViewController?.searchCriteria = criterias[sender.selectedSegmentIndex]
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case tableViewSegue:
            guard let destinationVc = segue.destination as? SearchTableViewController else {
                return
            }
            self.searhTableViewController = destinationVc
            break;
        default:
            return
        }
    }
}
