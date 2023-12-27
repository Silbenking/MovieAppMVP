//
//  TopChartViewCell.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 13.12.2023.
//

import UIKit

final class TopChartViewCell: UITableViewCell {

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

    // MARK: - configure Data Cell
    
    func configure(topCharts: TopChartsModel, indexPath: IndexPath) {
        
        guard let url = URL(string: topCharts.docs?[indexPath.row].poster?.previewURL ?? "nil") else {return}
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.movieImage.image = UIImage(data: data!)
            }
        }

        numberMovieLabel.text = "\(topCharts.docs?[indexPath.row].top250 ?? 9)"
        nameMovieLabel.text = topCharts.docs?[indexPath.row].name
        categoryMovieLabel.text = topCharts.docs?[indexPath.row].countries?.first?.name
    }
    
}
