//
//  TopChartErrorAlert.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 30.12.2023.
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
