//
//  TopChartView.swift
//  MovieAppMVP
//
//

import UIKit

public final class TopChartView: UIView {

    var tableView: UITableView!

    private let topChartLabel: UILabel = {
         let label = UILabel()
         label.text = "Топ фильмов"
         label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .orange.withAlphaComponent(0.8)
         label.textAlignment = .left
         return label
     }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        embedViews()
        setupLayout()
        setupTableView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - setup TableView

    func setupTableView() {
        tableView = UITableView()
        self.addSubview(tableView)
        tableView.register(FilmCell.self, forCellReuseIdentifier: FilmCell.identifier)
        tableView.backgroundColor = .black
        tableView.rowHeight = UITableView.automaticDimension
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topChartLabel.snp.bottom).inset(-30)
            make.bottom.leading.trailing.equalToSuperview().inset(10)
        }
    }
    // MARK: - setup Layout

    func setupLayout() {
        topChartLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
    }
    // MARK: - embed Views

    func embedViews() {
        [topChartLabel].forEach {self.addSubview($0)}
    }
    
}
