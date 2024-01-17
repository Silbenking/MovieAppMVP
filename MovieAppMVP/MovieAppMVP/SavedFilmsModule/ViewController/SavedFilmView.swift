//
//  SavedFilmView.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 31.12.2023.
//

import UIKit

final class SavedFilmView: UIView {

   lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SavedFilmCell.self, forCellReuseIdentifier: SavedFilmCell.identifier)
        tableView.backgroundColor = .black
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Очистить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.secondaryLabel, for: .highlighted)
        return button
    }()

    private lazy var savedLabel: UILabel = {
        let label = UILabel()
        label.text = "Избранное"
        label.font = .systemFont(ofSize: UIConstant.savedLabelSize, weight: .bold)
        label.textColor = .orange.withAlphaComponent(UIConstant.savedLabelWithAlphaComponent)
        label.textAlignment = .left
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - setup View

    private func setupView() {
        addSubview(savedLabel)
        addSubview(tableView)
        addSubview(clearButton)
    }

    // MARK: - setup Layout

    private func setupLayout() {
        savedLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(UIConstant.savedLabelLeading)
            make.top.equalTo(self.safeAreaLayoutGuide).inset(UIConstant.savedLabelTop)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(savedLabel.snp.bottom).inset(UIConstant.tableTop)
            make.bottom.leading.trailing.equalToSuperview().inset(UIConstant.tableHorizontal)
        }
        clearButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(UIConstant.clearButtonTrailing)
            make.top.equalTo(self.safeAreaLayoutGuide).inset(UIConstant.savedLabelTop)
        }
    }
}

private extension SavedFilmView {
    // MARK: - UIConstant

    private enum UIConstant {
        static let savedLabelSize: CGFloat = 30
        static let savedLabelWithAlphaComponent: CGFloat = 0.8
        static let savedLabelLeading: CGFloat = 20
        static let savedLabelTop: CGFloat = 30
        static let tableTop: CGFloat = -30
        static let tableHorizontal: CGFloat = 10
        static let clearButtonTrailing: CGFloat = 10

    }
}
