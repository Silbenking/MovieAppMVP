//
//  DetailMovieView.swift
//  MovieAppMVP
//
//

import UIKit

final class DetailMovieView: UIView {

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
        label.font = .systemFont(ofSize: FontSize.nameMovieLabel)
        label.numberOfLines = .zero
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

    private lazy var yearOfReleaseLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FontSize.yearOfReleaseLabel)
        label.textAlignment = .left
        label.textColor = .systemGray
        return label
    }()

    private lazy var countryMovieLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FontSize.countryMovieLabel)
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
        label.font = .systemFont(ofSize: FontSize.ratingTextLabel, weight: .bold)
        label.textAlignment = .left
        label.textColor = .systemGray
        return label
    }()

    private lazy var descriptionMovieLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: FontSize.descriptionMovieLabel)
        label.isUserInteractionEnabled = true
        label.numberOfLines = 5
        return label
    }()

    private lazy var readMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("читать больше..", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: FontSize.readMoreButton)
        button.setTitleColor(UIColor.secondaryLabel, for: .highlighted)
        return button
    }()

     let saveButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
         configuration.imagePadding = UIConstant.saveButtonButtonImagePadding
        configuration.cornerStyle = .capsule
         configuration.baseBackgroundColor = .orange.withAlphaComponent(UIConstant.saveButtonWithAlphaComponent)

        let button = UIButton(configuration: configuration, primaryAction: nil)
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

    // MARK: - configure Cell

    func configure(with model: Film) {
        guard let url = URL(string: model.movieImage ) else {return}
        movieImage.kf.setImage(with: url)
        movieImage.kf.indicatorType = .activity

        nameMovieLabel.text = model.nameMovie
        countryMovieLabel.text = model.countryMovie
        yearOfReleaseLabel.text = model.yearOfRealiseMovie
        ratingTextLabel.text = model.ratingMovie
        descriptionMovieLabel.text = model.descriptionMovie
    }

    private func addTarget() {

        readMoreButton.addTarget(self, action: #selector(labelAction), for: .touchUpInside)
    }
    // MARK: - label Action

    @objc func labelAction() {
            if descriptionMovieLabel.numberOfLines == 5 {
                descriptionMovieLabel.numberOfLines = .zero
                readMoreButton.setTitle("Свернуть", for: .normal)
            } else {
                descriptionMovieLabel.numberOfLines = 5
                readMoreButton.setTitle("читать больше..", for: .normal)
            }
    }
    // MARK: - setupLayout

    private func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(Spacing.scrollViewTop)
        }

        movieImage.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(Size.movieImageHeight)
        }

        nameMovieLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.bottom).offset(Spacing.nameMovieLabelTop)
            make.leading.equalToSuperview().offset(Spacing.nameMovieLabelLeading)
            make.width.equalTo(Size.nameMovieLabelWidth)
        }

        countryMovieLabel.snp.makeConstraints { make in
            make.top.equalTo(nameMovieLabel.snp.bottom).offset(Spacing.countryMovieLabelTop)
            make.leading.equalToSuperview().offset(Spacing.countryMovieLabelLeading)
        }

        yearOfReleaseLabel.snp.makeConstraints { make in
            make.top.equalTo(nameMovieLabel.snp.bottom).offset(Spacing.yearOfReleaseLabelTop)
            make.leading.equalTo(countryMovieLabel.snp.trailing).offset(Spacing.yearOfReleaseLabelLeading)
        }

        ratingMovieImage.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.bottom).offset(Spacing.ratingMovieImageTop)
            make.width.equalTo(Size.ratingMovieImageWidth)
            make.leading.equalTo(nameMovieLabel.snp.trailing)
            make.height.equalTo(Size.ratingMovieImageHeight)
        }

        ratingTextLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingMovieImage.snp.bottom)
            make.centerX.equalTo(ratingMovieImage.snp.centerX)
        }
        descriptionMovieLabel.sizeToFit()
        descriptionMovieLabel.snp.makeConstraints { make in
            make.top.equalTo(countryMovieLabel.snp.bottom).offset(Spacing.descriptionMovieLabelTop)
            make.width.equalToSuperview().inset(Size.descriptionMovieLabelWidth)
            make.leading.equalToSuperview().inset(Spacing.descriptionMovieLabelLeading)
        }

        readMoreButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionMovieLabel.snp.bottom).inset(Spacing.readMoreButtonTop)
            make.leading.equalToSuperview().offset(Spacing.readMoreButtonLeading)
        }

        saveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionMovieLabel.snp.bottom).offset(Spacing.saveButtonTop)
            make.bottom.equalTo(scrollView.snp.bottom).inset(Spacing.saveButtonBottom)
            make.size.equalTo(CGSize(width: Size.saveButtonWidth, height: Size.saveButtonHeight))
        }
    }
    // MARK: - embed Views

    private func embedViews() {

        self.addSubview(scrollView)
        [movieImage, nameMovieLabel, yearOfReleaseLabel, countryMovieLabel, ratingMovieImage, ratingTextLabel, descriptionMovieLabel, readMoreButton, saveButton].forEach {scrollView.addSubview($0)}

    }
    // MARK: - setup Appearance

    private func setupAppearance() {

        self.backgroundColor = .black

    }
    // MARK: - UIConstant

    private enum FontSize {
            static let nameMovieLabel: CGFloat = 32
            static let yearOfReleaseLabel: CGFloat = 15
            static let countryMovieLabel: CGFloat = 15
            static let ratingTextLabel: CGFloat = 32
            static let descriptionMovieLabel: CGFloat = 15
            static let readMoreButton: CGFloat = 12
        }

    private enum Size {
            static let nameMovieLabelWidth: CGFloat = 250
            static let ratingMovieImageWidth: CGFloat = 100
            static let ratingMovieImageHeight: CGFloat = 30
            static let saveButtonHeight: CGFloat = 42
            static let saveButtonWidth: CGFloat = 211
            static let descriptionMovieLabelWidth: CGFloat = 10
            static let movieImageHeight: CGFloat = 442
        }

    private enum Spacing {
            static let scrollViewTop: CGFloat = 60
            static let nameMovieLabelTop: CGFloat = 10
            static let nameMovieLabelLeading: CGFloat = 20
            static let countryMovieLabelTop: CGFloat = 7
            static let countryMovieLabelLeading: CGFloat = 20
            static let yearOfReleaseLabelTop: CGFloat = 7
            static let yearOfReleaseLabelLeading: CGFloat = 10
            static let ratingMovieImageTop: CGFloat = 7
            static let descriptionMovieLabelTop: CGFloat = 10
            static let descriptionMovieLabelLeading: CGFloat = 5
            static let readMoreButtonTop: CGFloat = 5
            static let readMoreButtonLeading: CGFloat = 300
            static let saveButtonTop: CGFloat = 40
            static let saveButtonBottom: CGFloat = 50
        }
    private enum UIConstant {
        static let movieImageCornerRadius: CGFloat = 10
        static let saveButtonButtonImagePadding: CGFloat = 10
        static let saveButtonWithAlphaComponent: CGFloat = 0.8
    }
}
