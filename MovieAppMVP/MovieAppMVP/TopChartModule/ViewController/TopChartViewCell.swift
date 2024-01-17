//
//  TopChartViewCell.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 13.12.2023.
//

import UIKit
import Kingfisher

final class TopChartViewCell: UITableViewCell {

    static let identifaerTop = "TopChartViewCell"

    private let numberMovieLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()

    private let movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let nameMovieLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()

    private let categoryMovieLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.textAlignment = .left
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - setup Layout
    private func setupLayout() {
        [numberMovieLabel, movieImage, nameMovieLabel, categoryMovieLabel].forEach {contentView.addSubview($0)}

        contentView.backgroundColor = .black

        numberMovieLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5)
            make.top.equalToSuperview().inset(10)
        }

        movieImage.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 150, height: 150))
            make.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(25)
        }

        nameMovieLabel.snp.makeConstraints { make in
            make.leading.equalTo(movieImage.snp.trailing).offset(10)
            make.top.equalToSuperview().inset(40)
            make.trailing.equalToSuperview().inset(5)
        }
        categoryMovieLabel.snp.makeConstraints { make in
            make.leading.equalTo(movieImage.snp.trailing).offset(10)
            make.bottom.equalToSuperview().inset(40)
        }
    }
    // MARK: - load Image
    func loadImage(imageUrl: String) {
        guard let url = URL(string: imageUrl ) else {return}
        movieImage.kf.setImage(with: url)
        movieImage.kf.indicatorType = .activity
    }

    // MARK: - configure Data Cell

    func configure(with model: ViewModel) {
        loadImage(imageUrl: model.imageMovie)
        numberMovieLabel.text = model.movieNumber
        nameMovieLabel.text = model.movieName
        categoryMovieLabel.text = model.movieCategory
    }
}

extension TopChartViewCell {
    struct ViewModel {
        let movieName: String
        let movieNumber: String
        let movieCategory: String
        let imageMovie: String
    }
}
