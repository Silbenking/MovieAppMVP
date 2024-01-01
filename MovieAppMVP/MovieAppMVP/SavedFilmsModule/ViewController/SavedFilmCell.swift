//
//  SavedFilmCell.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 31.12.2023.
//

import UIKit

class SavedFilmCell: UITableViewCell {

    static let ideintifier = "SavedFilmCell"
    
    private let movieImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "test")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let nameMovieLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "NAME"
        label.textColor = .white
        return label
    }()
    
    private let categoryMovieLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.text = "Country"
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
        [movieImage, nameMovieLabel, categoryMovieLabel].forEach {contentView.addSubview($0)}
        
        contentView.backgroundColor = .black
        
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
    // MARK: - configure Data Cell
    
    func configure(with model: SavedModel) {
//        loadImage(imageUrl: model.imageMovie)
        movieImage.image = UIImage(named: model.image)
        nameMovieLabel.text = model.name
        categoryMovieLabel.text = model.categoty    
        
    }
//    func configure(with model: ViewModel) {
////        loadImage(imageUrl: model.imageMovie)
//        movieImage.image = UIImage(named: model.imageMovie)
//        nameMovieLabel.text = model.movieName
//        categoryMovieLabel.text = model.movieCategory
//        
//    }
}

extension SavedFilmCell {
    struct ViewModel {
        let movieName: String
        let movieCategory: String
        let imageMovie: String
    }
}
