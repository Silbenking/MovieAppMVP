//
//  ViewController.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 12.12.2023.
//

import UIKit
import SnapKit

protocol TopChartVCProtocol: AnyObject {//функции, которые должны выполняться при взаимодействии с пользовательским интерфейсом (viewProtocol) - ОПИСЫВАЕМ ТЕ ДЕЙСТВИЯ КОТОРЫЕ ВЬЮ ДОЛЖНА ВЫПОЛНЯТЬ(отображение полей логина, авторизации и тд)
    func setupLayout()
    func embedViews()
    func setupTableView()
}

final class TopChartsViewController: UIViewController {

    var presenter: TopChartPresenterProtocol!
    var tableView: UITableView! // почему создаем таким образом?
    var topChartArray = [TopChartsModel]()
    
    init(presenter: TopChartPresenterProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let topChartLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Charts"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        embedViews()
        setupLayout()
        setupTableView()
        networkService()
    }
}

extension TopChartsViewController: TopChartVCProtocol {
    
    // MARK: - Network Service
    
    func networkService() {
        NetworMoviewkService.shared.fetchData { [weak self] result in
            switch result {
            case .success(let movieResult):
                for _ in movieResult.docs! {
                    self?.topChartArray.append(movieResult)
                }
                print(movieResult)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                case .failure(let error):
                print(error)
            }
        }
    }
    // MARK: - setup TableView

    func setupTableView() { // и лучше все в одном месте настраивать и добавлять
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TopChartViewCell.self, forCellReuseIdentifier: "TopChartViewCell")
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
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
    }
    // MARK: - embed Views
    
    func embedViews() {
        [topChartLabel].forEach {view.addSubview($0)}
    }
}

extension TopChartsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        topChartArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopChartViewCell", for: indexPath) as? TopChartViewCell else {fatalError()}
        let topChartArray = topChartArray[indexPath.row]
        cell.configure(topCharts: topChartArray, indexPath: indexPath)
        return cell
    }
}

extension TopChartsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailMovieViewController()
        if let detail = topChartArray.first?.docs?[indexPath.row] {
            detailVC.configure(detailModel: self.topChartArray[indexPath.row], indexPath: indexPath)
        }
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .orange.withAlphaComponent(0.8)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
