//
//  SearchTableViewCell.swift
//  StartWarsRemake
//
//  Created by Muñoz, Jesus Manuel on 14/3/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(item: Displayable) {
        title.text = item.titleLabelText
        subtitle.text = item.subtitleLabelText
    }
}
