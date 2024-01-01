//
//  DetailMovieViewController.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 19.12.2023.
//

import UIKit
import SnapKit
import Kingfisher

protocol DetailMovieVCProtocol: AnyObject {
    
    func saveButton()
    
}

final class DetailMovieViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private var presenter: DetailMoviePresenterProtocol!
    let detailMovieView = DetailMovieView()
        
    init(presenter: DetailMoviePresenterProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = detailMovieView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addActionButton()
    }
    
}

extension DetailMovieViewController: DetailMovieVCProtocol {
    
    func addActionButton() {

        detailMovieView.saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        
    }
    
    func saveButton() {
        detailMovieView.saveButton.isSelected = !detailMovieView.saveButton.isSelected
      
        if detailMovieView.saveButton.isSelected {
            detailMovieView.saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            detailMovieView.saveButton.setTitle("Сохранено", for: .normal)
            
        } else {
            detailMovieView.saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            detailMovieView.saveButton.setTitle("Сохранить", for: .normal)
        }
    }
    
    @objc func saveAction() {
        presenter.handleSaveMovieButton()
    }
    
}
