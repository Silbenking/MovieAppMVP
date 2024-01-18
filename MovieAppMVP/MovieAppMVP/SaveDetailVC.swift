//
//  SaveDetailVC.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 14.01.2024.
//

import UIKit
import Kingfisher

protocol SaveDetailVCProtocol: AnyObject {

}

final class SaveDetailVC: UIViewController {

    let detailMovieView = SaveDetailView()

    override func loadView() {
        self.view = detailMovieView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
}
