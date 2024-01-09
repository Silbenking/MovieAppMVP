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
        image.layer.cornerRadius = UIConstant.movieImageCornerRadius
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var nameMovieLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstant.nameMovieLabelFontSize)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private lazy var yearOfReleaseLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstant.yearOfReleaseLabelFontSize)
        label.textAlignment = .left
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var countryMovieLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstant.countryMovieLabelFontSize)
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
        label.font = .systemFont(ofSize: UIConstant.ratingTextLabelFontSize, weight: .bold)
        label.textAlignment = .left
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var descriptionMovieLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: UIConstant.descriptionMovieLabelFontSize)
        label.isUserInteractionEnabled = true
        label.numberOfLines = 7
        return label
    }()
    
    private lazy var readMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("читать больше..", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: UIConstant.readMoreButtonFontSize)
        button.setTitleColor(UIColor.secondaryLabel, for: .highlighted)
        return button
    }()
    
     let saveButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
         configuration.imagePadding = UIConstant.saveButtonButtonImagePadding
        configuration.cornerStyle = .capsule
         configuration.baseBackgroundColor = .orange.withAlphaComponent(UIConstant.saveButtonWithAlphaComponent)
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.setTitle("Сохранить", for: .normal)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        return button
        
    }()
    
    // MARK: - UIConstant

    private enum UIConstant {
        static let movieImageCornerRadius: CGFloat = 10
        static let nameMovieLabelFontSize: CGFloat = 32
        static let yearOfReleaseLabelFontSize: CGFloat = 15
        static let countryMovieLabelFontSize: CGFloat = 15
        static let ratingTextLabelFontSize: CGFloat = 32
        static let descriptionMovieLabelFontSize: CGFloat = 15
        static let readMoreButtonFontSize: CGFloat = 12
        static let saveButtonButtonImagePadding: CGFloat = 10
        static let saveButtonWithAlphaComponent: CGFloat = 0.8
        
        static let scrollViewTop: CGFloat = 60
        static let movieImageHeight: CGFloat = 442
        static let nameMovieLabelTop: CGFloat = 10
        static let nameMovieLabelLeading: CGFloat = 20
        static let nameMovieLabelWidth: CGFloat = 250
        static let countryMovieLabelTop: CGFloat = 7
        static let countryMovieLabelLeading: CGFloat = 20
        static let yearOfReleaseLabelTop: CGFloat = 7
        static let yearOfReleaseLabelLeading: CGFloat = 10
        static let ratingMovieImageTop: CGFloat = 7
        static let ratingMovieImageWidth: CGFloat = 100
        static let ratingMovieImageHeight: CGFloat = 30
        static let descriptionMovieLabelTop: CGFloat = 10
        static let descriptionMovieLabelWidth: CGFloat = 10
        static let descriptionMovieLabelLeading: CGFloat = 5
        static let readMoreButtonTop: CGFloat = 5
        static let readMoreButtonLeading: CGFloat = 300
        static let saveButtonTop: CGFloat = 40
        static let saveButtonBottom: CGFloat = 50
        static let saveButtonHeight: CGFloat = 42
        static let saveButtonWidth: CGFloat = 211

    }
    
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
            make.top.equalToSuperview().inset(UIConstant.scrollViewTop)
        }

        movieImage.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(UIConstant.movieImageHeight)
        }
        
        nameMovieLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.bottom).offset(UIConstant.nameMovieLabelTop)
            make.leading.equalToSuperview().offset(UIConstant.nameMovieLabelLeading)
            make.width.equalTo(UIConstant.nameMovieLabelWidth)
        }
        
        countryMovieLabel.snp.makeConstraints { make in
            make.top.equalTo(nameMovieLabel.snp.bottom).offset(UIConstant.countryMovieLabelTop)
            make.leading.equalToSuperview().offset(UIConstant.countryMovieLabelLeading)
        }
        
        yearOfReleaseLabel.snp.makeConstraints { make in
            make.top.equalTo(nameMovieLabel.snp.bottom).offset(UIConstant.yearOfReleaseLabelTop)
            make.leading.equalTo(countryMovieLabel.snp.trailing).offset(UIConstant.yearOfReleaseLabelLeading)
        }
        
        ratingMovieImage.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.bottom).offset(UIConstant.ratingMovieImageTop)
            make.width.equalTo(UIConstant.ratingMovieImageWidth)
            make.leading.equalTo(nameMovieLabel.snp.trailing)
            make.height.equalTo(UIConstant.ratingMovieImageHeight)
        }
        
        ratingTextLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingMovieImage.snp.bottom)
            make.centerX.equalTo(ratingMovieImage.snp.centerX)
        }
        
        descriptionMovieLabel.snp.makeConstraints { make in
            make.top.equalTo(countryMovieLabel.snp.bottom).offset(UIConstant.descriptionMovieLabelTop)
            make.width.equalToSuperview().inset(UIConstant.descriptionMovieLabelWidth)
            make.leading.equalToSuperview().inset(UIConstant.descriptionMovieLabelLeading)
        }
        
        readMoreButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionMovieLabel.snp.bottom).inset(UIConstant.readMoreButtonTop)
            make.leading.equalToSuperview().offset(UIConstant.readMoreButtonLeading)
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionMovieLabel.snp.bottom).offset(UIConstant.saveButtonTop)
            make.bottom.equalTo(scrollView.snp.bottom).inset(UIConstant.saveButtonBottom)
            make.size.equalTo(CGSize(width: UIConstant.saveButtonWidth, height: UIConstant.saveButtonHeight))
        }
        
    }
    // MARK: - embed Views
    
    private func embedViews() {
        
        self.addSubview(scrollView)
        [movieImage, nameMovieLabel, yearOfReleaseLabel, countryMovieLabel, ratingMovieImage, ratingTextLabel, descriptionMovieLabel, readMoreButton, saveButton].forEach {scrollView.addSubview($0)}
        
    }
    // MARK: - setup Appearance

    func setupAppearance() {
        
        self.backgroundColor = .black
        
    }
    
    // MARK: - configure Cell

    func configure(with model: ViewModel) {
        guard let url = URL(string: model.movieImage ) else {return}
        movieImage.kf.setImage(with: url)
        
        nameMovieLabel.text = model.nameMovie
        countryMovieLabel.text = model.countryMovie
        yearOfReleaseLabel.text = model.yearOfRealiseMovie
        ratingTextLabel.text = model.ratingMovie
        descriptionMovieLabel.text = model.descriptionMovie
    }
    
}
// MARK: - extension DetailMovieView

extension DetailMovieView {
    struct ViewModel {
        let nameMovie: String
        let movieImage: String
        let countryMovie: String
        let yearOfRealiseMovie: String
        let ratingMovie: String
        let descriptionMovie: String
    }
}
