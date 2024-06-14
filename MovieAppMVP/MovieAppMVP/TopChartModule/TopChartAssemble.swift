//
//  TopChartAssemble.swift
//  MovieAppMVP
//
//

import Foundation
import UIKit

struct TopChartAssemble { 

    static func assemble() -> UIViewController {
        let networkService = NetworkMoviekService()
        let presenter = TopChartPresenter(networMoviewkService: networkService)
        let viewController = TopChartsViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
