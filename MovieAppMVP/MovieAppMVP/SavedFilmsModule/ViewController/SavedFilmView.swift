//
//  SavedFilmView.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 31.12.2023.
//

import UIKit

class SavedFilmView: UIView {

    var tableView: UITableView!
    
    private lazy var savedLabel: UILabel = {
         let label = UILabel()
         label.text = "Избранное"
         label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .orange.withAlphaComponent(0.8)
         label.textAlignment = .left
         return label
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(savedLabel)
        savedLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(self.safeAreaLayoutGuide).inset(30)
        }
    }
    
    func setupTableView() {
        tableView = UITableView()
        self.addSubview(tableView)
        tableView.register(SavedFilmCell.self, forCellReuseIdentifier: "SavedFilmCell")
        tableView.backgroundColor = .black
        tableView.rowHeight = UITableView.automaticDimension
        tableView.snp.makeConstraints { make in
            make.top.equalTo(savedLabel.snp.bottom).inset(-30)
            make.bottom.leading.trailing.equalToSuperview().inset(10)
        }
    }
}
