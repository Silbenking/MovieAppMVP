//
//  SavedFilmsVC.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 31.12.2023.
//
import UIKit
import SnapKit
import RealmSwift

protocol SavedFilmsVCProtocol: AnyObject {
    func reloadTableView()
}

class SavedFilmsVC: UIViewController {

    private var presenter: SavedFilmsPresenterProtocol!
    let savedView = SavedFilmView()
    
    let realm = try! Realm()
    var saveArray: Results<SavedModel>!
    
    init(presenter: SavedFilmsPresenterProtocol!) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = savedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveArray = realm.objects(SavedModel.self)
        setupTableView()
        presenter.notificationAddObserverReloadTable()
    }
    // MARK: - setup TableView
    
   private func setupTableView() {
        savedView.tableView.dataSource = self
    }
}
// MARK: - extension View

extension SavedFilmsVC: SavedFilmsVCProtocol {
    func reloadTableView() {
        savedView.tableView.reloadData()
    }
}
// MARK: - setup TableViewDataSource

extension SavedFilmsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        saveArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedFilmCell.identifier, for: indexPath) as? SavedFilmCell else {fatalError()}
        let array = saveArray[indexPath.row]
        let model = SavedFilmCell.ViewModel(movieName: array.nameMovie,
                                            movieCategory: array.countryMovie,
                                            imageMovie: array.imgeMovie)
        cell.configure(with: model)
        return cell
    }
    
}
