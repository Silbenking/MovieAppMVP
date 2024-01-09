//
//  SavedFilmCell.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 31.12.2023.
//

import UIKit

class SavedFilmCell: UITableViewCell {

    static let identifier = "SavedFilmCell"
    
    private lazy var movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var nameMovieLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private lazy var categoryMovieLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - UIConstant

    private enum UIConstant {
        static let movieImageSize: CGFloat = 150
        static let movieImageTop: CGFloat = 10
        static let movieImageBottom: CGFloat = 10
        static let movieImageLeading: CGFloat = 25
        
        static let nameMovieLabelTop: CGFloat = 40
        static let nameMovieLabelTrailing: CGFloat = 5
        static let nameMovieLabelLeading: CGFloat = 10
        
        static let categoryMovieLabelBottom: CGFloat = 40
        static let categoryMovieLabelLeading: CGFloat = 10

    }
    
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
            make.size.equalTo(CGSize(width: UIConstant.movieImageSize, height: UIConstant.movieImageSize))
            make.top.equalToSuperview().inset(UIConstant.movieImageTop)
            make.bottom.equalToSuperview().inset(UIConstant.movieImageBottom)
            make.leading.equalToSuperview().offset(UIConstant.movieImageLeading)
        }
        
        nameMovieLabel.snp.makeConstraints { make in
            make.leading.equalTo(movieImage.snp.trailing).offset(UIConstant.nameMovieLabelLeading)
            make.top.equalToSuperview().inset(UIConstant.nameMovieLabelTop)
            make.trailing.equalToSuperview().inset(UIConstant.nameMovieLabelTrailing)
        }
        categoryMovieLabel.snp.makeConstraints { make in
            make.leading.equalTo(movieImage.snp.trailing).offset(UIConstant.categoryMovieLabelLeading)
            make.bottom.equalToSuperview().inset(UIConstant.categoryMovieLabelBottom)
        }
    }
    // MARK: - load Image
    private func loadImage(imageUrl: String) {
        guard let url = URL(string: imageUrl ) else {return}
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.movieImage.image = UIImage(data: data!)
            }
        }
    }
    
    // MARK: - configure Data Cell
    
    func configure(with model: ViewModel) {
        loadImage(imageUrl: model.imageMovie)
        nameMovieLabel.text = model.movieName
        categoryMovieLabel.text = model.movieCategory
        
    }
}
// MARK: - SavedFilm Cell

extension SavedFilmCell {
    struct ViewModel {
        let movieName: String
        let movieCategory: String
        let imageMovie: String
    }
}
