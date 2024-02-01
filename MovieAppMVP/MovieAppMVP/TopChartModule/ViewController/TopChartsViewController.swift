//
//  ViewController.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 12.12.2023.
//

import UIKit
import SnapKit

protocol TopChartVCProtocol: AnyObject {
    func reloadData()
    func errorDecode()
    func errorNetwork()
}

final class TopChartsViewController: UIViewController {

    private let router: DetailRouterProtocol = DetailRouter()
    private var presenter: TopChartPresenterProtocol!
    var topChartArray = [TopChartsModel]()
    let topView = TopChartView()

    init(presenter: TopChartPresenterProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = topView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        tableViewDelegate()
    }
}

extension TopChartsViewController: TopChartVCProtocol {
    // MARK: - Error networkServixe

    func errorDecode() {
        errorAlert(nameError: "Ошибка декодирования")
    }

    func errorNetwork() {
        errorAlert(nameError: "Ошибка сети")
    }

    // MARK: - Reload Data

    func reloadData() {
        DispatchQueue.main.async {
            self.topView.tableView.reloadData()
        }
    }

    func tableViewDelegate() {
        topView.tableView.dataSource = self
        topView.tableView.delegate = self
    }
}

extension TopChartsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.dataSource.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilmCell.identifier, for: indexPath) as? FilmCell else {fatalError()}
        let topChartArray = presenter.dataSource[indexPath.row]
        cell.configure(with: topChartArray)
        return cell
    }
}

extension TopChartsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = presenter.dataSource[indexPath.row]
        router.showDetailMovie(from: self, model: detail)

    }
}
