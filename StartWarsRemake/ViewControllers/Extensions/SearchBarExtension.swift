//
//  SearchBarExtension.swift
//  StartWarsRemake
//
//  Created by Muñoz, Jesus Manuel on 19/3/21.
//

import Foundation
import UIKit

extension UISearchBar {
    func setEnabled(enable: Bool) {
        if (enable) {
            isUserInteractionEnabled = true
            alpha = 1.0
        } else {
            isUserInteractionEnabled = false
            alpha = 0.5
        }
    }
}
