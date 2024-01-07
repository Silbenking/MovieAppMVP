//
//  DetailMovieView.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 29.12.2023.
//

import UIKit

class DetailMovieView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .black
        return scrollView
    }()
    
    private lazy var movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var nameMoviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private lazy var yearOfReleaseLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var countryMovieLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .systemGray
        return label
    }()

    private lazy var ratingMovieImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "kinopoisk")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var ratingTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.textAlignment = .left
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var descriptionMovieLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 15)
        label.isUserInteractionEnabled = true
        label.numberOfLines = 7
        return label
    }()
    
    private lazy var readMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("читать больше..", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(UIColor.secondaryLabel, for: .highlighted)
        return button
    }()
    
     let saveButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.imagePadding = 10
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = .orange.withAlphaComponent(0.8)
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.setTitle("Сохранить", for: .normal)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        return button
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        embedViews()
        setupLayout()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addTarget() {
        
        readMoreButton.addTarget(self, action: #selector(labelAction), for: .touchUpInside)
    }
    // MARK: - label Action
    
    @objc func labelAction() {
            if descriptionMovieLabel.numberOfLines == 7 {
                descriptionMovieLabel.numberOfLines = 0
                readMoreButton.setTitle("Свернуть", for: .normal)
            } else {
                descriptionMovieLabel.numberOfLines = 7
                readMoreButton.setTitle("читать больше..", for: .normal)
            }
    }
    // MARK: - setupLayout

    private func setupLayout() {
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
    // MARK: - embed Views
    private func embedViews() {
        
        self.addSubview(scrollView)
        [movieImage, nameMoviewLabel, yearOfReleaseLabel, countryMovieLabel, ratingMovieImage, ratingTextLabel, descriptionMovieLabel, readMoreButton, saveButton].forEach {scrollView.addSubview($0)}
        
    }
    // MARK: - setup Apperance

    func setupApperance() {
        
        self.backgroundColor = .black
        
    }
    
    func configure(with model: ViewModel) {
        guard let url = URL(string: model.movieImage ) else {return}
        movieImage.kf.setImage(with: url)
        
        nameMoviewLabel.text = model.nameMovie
        countryMovieLabel.text = model.countryMovie
        yearOfReleaseLabel.text = model.yearOfRealeseMovie
        ratingTextLabel.text = model.ratingMovie
        descriptionMovieLabel.text = model.descriptionMovie
    }
    
}

extension DetailMovieView {
    struct ViewModel {
        let nameMovie: String
        let movieImage: String
        let countryMovie: String
        let yearOfRealeseMovie: String
        let ratingMovie: String
        let descriptionMovie: String
    }
}
