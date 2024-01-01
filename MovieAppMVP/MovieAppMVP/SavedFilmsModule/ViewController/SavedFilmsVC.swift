//
//  SavedFilmsVC.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 31.12.2023.
//

import UIKit
import SnapKit

protocol SavedFilmsVCProtocol: AnyObject {
    
}

class SavedFilmsVC: UIViewController {

    private var presenter: SavedFilmsPresenterProtocol!
    let savedView = SavedFilmView()
    var savedArrayModel: [TopChartsModel] = []
    
    let savedArray = [SavedModel(name: "name", categoty: "Russya", image: "test"),
                      SavedModel(name: "name", categoty: "Russya", image: "test"),
                      SavedModel(name: "name", categoty: "Russya", image: "test"),
                      SavedModel(name: "name", categoty: "Russya", image: "test"),
                      SavedModel(name: "name", categoty: "Russya", image: "test")]
    
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
        setupTableView()
    }
    
    func setupTableView() {
        savedView.tableView.dataSource = self
    }
    
}

extension SavedFilmsVC: SavedFilmsVCProtocol {
    
}

extension SavedFilmsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedFilmCell.ideintifier, for: indexPath) as? SavedFilmCell else {fatalError()}
        let array = savedArray[indexPath.row]
        cell.configure(with: array)
        return cell
    }
    
}
