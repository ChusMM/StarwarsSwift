//
//  ViewControllerExtension.swift
//  StartWarsRemake
//
//  Created by Muñoz, Jesus Manuel on 14/3/21.
//

import Foundation
import UIKit

fileprivate var vSpinner : UIView?

extension UIViewController {
    static var activityIndicatorTag = 12345

    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
        
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
    func showErrorAlert(errorMessage: String) {
        // create the alert
        let alert = UIAlertController(title: "Attention!", message: errorMessage, preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
