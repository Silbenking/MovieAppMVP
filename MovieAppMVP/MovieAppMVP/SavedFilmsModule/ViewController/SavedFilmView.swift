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
        label.font = .systemFont(ofSize: UIConstant.savedLabelSize, weight: .bold)
        label.textColor = .orange.withAlphaComponent(UIConstant.savedLabelWithAlphaComponent)
         label.textAlignment = .left
         return label
     }()
    // MARK: - UIConstant

    private enum UIConstant {
        static let savedLabelSize: CGFloat = 30
        static let savedLabelWithAlphaComponent: CGFloat = 0.8
        static let savedLabelLeading: CGFloat = 20
        static let savedLabelTop: CGFloat = 30
        static let tableTop: CGFloat = -30
        static let tableHorizontal: CGFloat = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - setup Layout

    private func setupLayout() {
        self.addSubview(savedLabel)
        savedLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(UIConstant.savedLabelLeading)
            make.top.equalTo(self.safeAreaLayoutGuide).inset(UIConstant.savedLabelTop)
        }
    }
    // MARK: - setup TableView

    private func setupTableView() {
        tableView = UITableView()
        self.addSubview(tableView)
        tableView.register(SavedFilmCell.self, forCellReuseIdentifier: "SavedFilmCell")
        tableView.backgroundColor = .black
        tableView.rowHeight = UITableView.automaticDimension
        tableView.snp.makeConstraints { make in
            make.top.equalTo(savedLabel.snp.bottom).inset(UIConstant.tableTop)
            make.bottom.leading.trailing.equalToSuperview().inset(UIConstant.tableHorizontal)
        }
    }
}
