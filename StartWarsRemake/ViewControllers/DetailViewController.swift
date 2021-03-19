//
//  DetailViewController.swift
//  StartWarsRemake
//
//  Created by Muñoz, Jesus Manuel on 19/3/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    @IBOutlet weak var item1Title: UILabel!
    @IBOutlet weak var item1: UILabel!
    @IBOutlet weak var item2Title: UILabel!
    @IBOutlet weak var item2: UILabel!
    @IBOutlet weak var item3Title: UILabel!
    @IBOutlet weak var item3: UILabel!
    
    var itemToDisplay: Displayable?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let displayable = self.itemToDisplay else {
            showErrorAlert(errorMessage: "No item selected")
            return
        }
        self.bindItem(displayable: displayable)
    }
    
    private func bindItem(displayable: Displayable) {
        mainTitle.text = displayable.titleLabelText
        subtitle.text = displayable.subtitleLabelText
        
        item1Title.text = displayable.item1.label
        item1.text = displayable.item1.value
        
        item2Title.text = displayable.item2.label
        item2.text = displayable.item2.value
        
        item3Title.text = displayable.item3.label
        item3.text = displayable.item3.value
    }
}
