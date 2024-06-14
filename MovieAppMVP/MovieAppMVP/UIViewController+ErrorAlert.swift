//
//  TopChartErrorAlert.swift
//  MovieAppMVP
//
//

import UIKit

extension UIViewController {
    func errorAlert(nameError: String) {
        let alert = UIAlertController(title: nameError, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
