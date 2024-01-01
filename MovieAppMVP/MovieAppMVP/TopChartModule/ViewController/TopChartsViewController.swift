//
//  ViewController.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 12.12.2023.
//

import UIKit
import SnapKit

protocol TopChartVCProtocol: AnyObject {//функции, которые должны выполняться при взаимодействии с пользовательским интерфейсом (viewProtocol) - ОПИСЫВАЕМ ТЕ ДЕЙСТВИЯ КОТОРЫЕ ВЬЮ ДОЛЖНА ВЫПОЛНЯТЬ(отображение полей логина, авторизации и тд)
    func reloadData()
    func errorDecode()
    func errorNetwork()
}

final class TopChartsViewController: UIViewController {
    
    private let router: DetailRouterProtocol = Router.shared
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
        presenter.loadData()
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
        presenter.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopChartViewCell.identifaerTop, for: indexPath) as? TopChartViewCell else {fatalError()}
        let topChartArray = presenter.dataSource[indexPath.row]
        let model =  TopChartViewCell.ViewModel(movieName: topChartArray.docs?[indexPath.row].name ?? "name", 
                                                movieNumber: "\(topChartArray.docs?[indexPath.row].top250 ?? 1)",
                                                movieCategory: topChartArray.docs?[indexPath.row].countries?.first?.name ?? "name",
                                                imageMovie: topChartArray.docs?[indexPath.row].poster?.url ?? "name")
        cell.configure(with: model)
        return cell
    }
}

extension TopChartsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = presenter.dataSource.first?.docs?[indexPath.row]
        let model = DetailMovieView.ViewModel(nameMovie: detail?.name ?? "name",
                                  movieImage: detail?.poster?.url ?? "test",
                                  countryMovie: detail?.countries?.first?.name ?? "country",
                                  yearOfRealeseMovie: "\(detail?.year ?? 1)",
                                  ratingMovie: "\(detail?.rating?.imdb ?? 8.5)",
                                  descriptionMovie: detail?.description ?? "description")
        router.showDetailMovie(from: self, model: model)
        
    }
}
