//
//  DetailMovieViewController.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 19.12.2023.
//

import UIKit
import SnapKit
import Kingfisher

protocol DetailMovieVCProtocol: AnyObject {
    func setupLayout()
    func embedViews()
    func setupApperance()
}

final class DetailMovieViewController: UIViewController, UIGestureRecognizerDelegate {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .black
        return scrollView
    }()
    
    private let movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private let nameMoviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let yearOfReleaseLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .systemGray
        return label
    }()
    
    private let countryMovieLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .systemGray
        return label
    }()

    private let ratingMovieImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "kinopoisk")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let ratingTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.textAlignment = .left
        label.textColor = .systemGray
        return label
    }()
    
    private let descriptionMovieLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 15)
        label.isUserInteractionEnabled = true
        label.numberOfLines = 7
        return label
    }()
    
    private let readMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("читать больше..", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(UIColor.secondaryLabel, for: .highlighted)
        return button
    }()
    
    private let saveButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.imagePadding = 10
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = .orange.withAlphaComponent(0.8)
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.setTitle("Сохранить", for: .normal)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        return button
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedViews()
        setupLayout()
        setupApperance()
        addActionButton()
    
    }
    
}

extension DetailMovieViewController: DetailMovieVCProtocol {
    
    func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(60)
        }

        movieImage.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(442)
        }
        
        nameMoviewLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(250)
        }
        
        countryMovieLabel.snp.makeConstraints { make in
            make.top.equalTo(nameMoviewLabel.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(20)
        }
        
        yearOfReleaseLabel.snp.makeConstraints { make in
            make.top.equalTo(nameMoviewLabel.snp.bottom).offset(7)
            make.leading.equalTo(countryMovieLabel.snp.trailing).offset(10)
        }
        
        ratingMovieImage.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.bottom).offset(7)
            make.width.equalTo(100)
            make.leading.equalTo(nameMoviewLabel.snp.trailing)
            make.height.equalTo(30)
        }
        
        ratingTextLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingMovieImage.snp.bottom)
            make.centerX.equalTo(ratingMovieImage.snp.centerX)
        }
        
        descriptionMovieLabel.snp.makeConstraints { make in
            make.top.equalTo(countryMovieLabel.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(5)
        }
        
        readMoreButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionMovieLabel.snp.bottom).inset(5)
            make.leading.equalToSuperview().offset(300)
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionMovieLabel.snp.bottom).offset(40)
            make.bottom.equalTo(scrollView.snp.bottom).inset(50)
            make.size.equalTo(CGSize(width: 211, height: 42))
        }
        
    }
    
    func embedViews() {
        
        view.addSubview(scrollView)
        [movieImage, nameMoviewLabel, yearOfReleaseLabel, countryMovieLabel, ratingMovieImage, ratingTextLabel, descriptionMovieLabel, readMoreButton, saveButton].forEach {scrollView.addSubview($0)}
        
    }
    
    func setupApperance() {
        
        view.backgroundColor = .black
        
    }
    
    func addActionButton() {
        
        readMoreButton.addTarget(self, action: #selector(labelAction), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        
    }
    
    func configure(detailModel: TopChartsModel, indexPath: IndexPath) {
        guard let url = URL(string: detailModel.docs?[indexPath.row].poster?.previewURL ?? "nil") else {return}
        movieImage.kf.setImage(with: url)
        
        nameMoviewLabel.text = detailModel.docs?[indexPath.row].name
        countryMovieLabel.text = detailModel.docs?[indexPath.row].countries?.first?.name
        yearOfReleaseLabel.text = "\(detailModel.docs?[indexPath.row].year ?? 1)"
        ratingTextLabel.text = "\(detailModel.docs?[indexPath.row].rating?.imdb ?? 8.5)"
        descriptionMovieLabel.text = detailModel.docs?[indexPath.row].description

    }
    
    @objc func labelAction() {

        if descriptionMovieLabel.numberOfLines == 7 {
            descriptionMovieLabel.numberOfLines = 0
            readMoreButton.setTitle("Свернуть", for: .normal)
        } else {
            descriptionMovieLabel.numberOfLines = 7
            readMoreButton.setTitle("читать больше..", for: .normal)
        }
    }
    
    @objc func saveAction() {
        saveButton.isSelected = !saveButton.isSelected
      
        if saveButton.isSelected {
            saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            saveButton.setTitle("Сохранено", for: .normal)
        } else {
            saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            saveButton.setTitle("Сохранить", for: .normal)
        }
    }
    
}
