//
//  ViewControllerExtension.swift
//  StartWarsRemake
//
//  Created by Muñoz, Jesus Manuel on 14/3/21.
//

import Foundation
import UIKit

extension UIViewController {
    static var activityIndicatorTag = 12345

    func startLoading() {
        stopLoading()

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.tag = UIViewController.activityIndicatorTag
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium

        DispatchQueue.main.async {
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
    }

    func stopLoading() {
        let activityIndicator = view.viewWithTag(UIViewController.activityIndicatorTag) as? UIActivityIndicatorView
        DispatchQueue.main.async {
            activityIndicator?.stopAnimating()
            activityIndicator?.removeFromSuperview()
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
