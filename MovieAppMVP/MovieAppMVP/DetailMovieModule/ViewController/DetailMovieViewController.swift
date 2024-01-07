//
//  DetailMovieViewController.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 19.12.2023.
//

import UIKit
import SnapKit
import Kingfisher
import RealmSwift

protocol DetailMovieVCProtocol: AnyObject {
    
    func saveButton()
    
}

final class DetailMovieViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private var presenter: DetailMoviePresenterProtocol!
    let detailMovieView = DetailMovieView()
    var movieDetailModel: DetailMovieView.ViewModel?
    let realm = try! Realm()
    
    let notificationCenter = NotificationCenter.default

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
        let value = SavedModel(value: [movieDetailModel?.nameMovie, movieDetailModel?.countryMovie, movieDetailModel?.movieImage])
        if detailMovieView.saveButton.isSelected {
            detailMovieView.saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            detailMovieView.saveButton.setTitle("Сохранено", for: .normal)
            try! realm.write({
                realm.add(value)
            })
            presenter.notificationReloadTable()
        } else {
            detailMovieView.saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            detailMovieView.saveButton.setTitle("Сохранить", for: .normal)
            try! realm.write({
                realm.delete(realm.objects(SavedModel.self))
            })
            presenter.notificationReloadTable()
    }
}
    
    @objc func saveAction() {
        presenter.handleSaveMovieButton()
    }
    
}
