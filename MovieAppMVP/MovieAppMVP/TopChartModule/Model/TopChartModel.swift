//
//  TopChartModel.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 13.12.2023.
//

import Foundation

// MARK: - MovieTop
struct TopChartsModel: Codable {
    let docs: [Doc]?
    let total, limit, page, pages: Int?
}

// MARK: - Doc
struct Doc: Codable {
    
    let rating, votes: Rating?
    let backdrop: Backdrop?
    let movieLength, id: Int?
    let name, description: String?
    let year: Int?
    let poster: Backdrop?
    let countries: [Country]?
//    let genres: [String]
    let typeNumber: Int?
    let alternativeName, enName: String?
    let names: [Name]?
    let ratingMPAA: String?
    let shortDescription: String?
    let ticketsOnSale: Bool?
    let ageRating: Int?
    let logo: Logo?
    let top250: Int?
    let isSeries: Bool?

}

// MARK: - Backdrop
struct Backdrop: Codable {
    let url, previewURL: String?

    enum CodingKeys: String, CodingKey {
        case url
        case previewURL = "previewUrl"
    }
}

// MARK: - Country
struct Country: Codable {
    let name: String?
}

// MARK: - Logo
struct Logo: Codable {
    let url: String?
}

// MARK: - Name
struct Name: Codable {
    let name, language: String?
    let type: String?
}

// MARK: - Rating
struct Rating: Codable {
    let kp, imdb, filmCritics, russianFilmCritics: Double?
    let ratingAwait: Int?

    enum CodingKeys: String, CodingKey {
        case kp, imdb, filmCritics, russianFilmCritics
        case ratingAwait = "await"
    }
}
