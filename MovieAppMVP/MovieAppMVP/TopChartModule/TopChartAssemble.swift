//
//  TopChartAssemble.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 13.12.2023.
//

import Foundation
import UIKit

struct TopChartAssemble { // непонятно как работает

    static func assemble() -> UIViewController {
        let networkService = NetworkMoviekService()
        let presenter = TopChartPresenter(networMoviewkService: networkService)
        let viewController = TopChartsViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
