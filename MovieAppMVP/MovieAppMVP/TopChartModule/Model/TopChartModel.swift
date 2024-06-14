//
//  TopChartModel.swift
//  MovieAppMVP
//
//

import Foundation

// MARK: - MovieTop
struct TopChartsModel: Decodable {
    let docs: [Doc]?
}

// MARK: - Doc
struct Doc: Decodable {
    let id: Int
    let rating: Rating?
    let name, description: String?
    let year: Int?
    let poster: Backdrop?
    let countries: [Country]?
    let typeNumber: Int?
    let top250: Int?

}

// MARK: - Backdrop
struct Backdrop: Decodable {
    let url, previewURL: String?

    enum CodingKeys: String, CodingKey {
        case url
        case previewURL = "previewUrl"
    }
}

// MARK: - Country
struct Country: Decodable {
    let name: String?
}

// MARK: - Rating
struct Rating: Decodable {
    let imdb: Double?
}
