//
//  Services.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 16.12.2023.
//

import Foundation
import Alamofire

protocol NetworMoviewkServiceProtocol {
    func fetchData(complition: @escaping (Result<TopChartsModel, NetworkMovieError>) -> Void)
    func fetchFilm(urlString: String, complition: @escaping (Result<TopChartsModel, NetworkMovieError>) -> Void)
}

enum NetworkMovieError: Error {
    case network
    case decode
}

final class NetworkMoviekService: NetworMoviewkServiceProtocol {

    func fetchData(complition: @escaping (Result<TopChartsModel, NetworkMovieError>) -> Void) {

        AF.request(Constant.movieTopUrl, headers: ["X-API-KEY": Constant.apyKey])
            .validate()
            .response { response in
                guard let data = response.data else {
                    if response.error != nil {
                        complition(.failure(.network))
                    }
                    return
                }
                let decoder = JSONDecoder()
                guard let moviewResult = try? decoder.decode(TopChartsModel.self, from: data) else {
                    complition(.failure(.decode))
                    return
                }
                complition(.success(moviewResult))

            }
    }

    func fetchFilm(urlString: String, complition: @escaping (Result<TopChartsModel, NetworkMovieError>) -> Void) {

        AF.request("https://api.kinopoisk.dev/v1.4/movie/search?page=1&limit=10&query=\(urlString)"
, headers: ["X-API-KEY": Constant.apyKey])
            .validate()
            .response { response in
                guard let data = response.data else {
                    if response.error != nil {
                        complition(.failure(.network))
                    }
                    return
                }
                let decoder = JSONDecoder()
                guard let moviewResult = try? decoder.decode(TopChartsModel.self, from: data) else {
                    complition(.failure(.decode))
                    return
                }
//                guard let film = Film(filmData: moviewResult) else {
//                    return complition(.failure(.decode))
//                }
                complition(.success(moviewResult))
            }
    }
}

private enum Constant {
    static let movieTopUrl =  "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=20&selectFields=id&selectFields=name&selectFields=alternativeName&selectFields=enName&selectFields=type&selectFields=year&selectFields=description&selectFields=shortDescription&selectFields=movieLength&selectFields=isSeries&selectFields=ticketsOnSale&selectFields=totalSeriesLength&selectFields=seriesLength&selectFields=ratingMpaa&selectFields=ageRating&selectFields=top10&selectFields=top250&selectFields=typeNumber&selectFields=status&selectFields=names&selectFields=logo&selectFields=poster&selectFields=backdrop&selectFields=rating&selectFields=votes&selectFields=genres&selectFields=countries&selectFields=releaseYears&sortField=top250&notNullFields=top250&sortType=1&lists=top250"

    static let apyKey = "WE3Y90J-F3KMXNJ-JY1FPMH-ED418Z5"
}
