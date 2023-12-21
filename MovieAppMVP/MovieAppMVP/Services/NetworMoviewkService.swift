//
//  Services.swift
//  MovieAppMVP
//
//  Created by Сергей Сырбу on 16.12.2023.
//

import Foundation
import Alamofire

final class NetworMoviewkService {
    
    static let shared = NetworMoviewkService()
    
    private init() {}
    
    func fetchData(complition: @escaping (Result<TopChartsModel, Error>) -> Void) {
        let movieTopUrl = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=20&selectFields=id&selectFields=name&selectFields=alternativeName&selectFields=enName&selectFields=type&selectFields=year&selectFields=description&selectFields=shortDescription&selectFields=movieLength&selectFields=isSeries&selectFields=ticketsOnSale&selectFields=totalSeriesLength&selectFields=seriesLength&selectFields=ratingMpaa&selectFields=ageRating&selectFields=top10&selectFields=top250&selectFields=typeNumber&selectFields=status&selectFields=names&selectFields=logo&selectFields=poster&selectFields=backdrop&selectFields=rating&selectFields=votes&selectFields=genres&selectFields=countries&selectFields=releaseYears&sortField=top250&sortType=1&lists=top250"
        
        AF.request(movieTopUrl, headers: ["X-API-KEY": "WE3Y90J-F3KMXNJ-JY1FPMH-ED418Z5"])
            .validate()
            .response { response in
                guard let data = response.data else {
                    if let error = response.error {
                        complition(.failure(error))
                    }
                    return
                }
                let decoder = JSONDecoder()
                guard let moviewResult = try? decoder.decode(TopChartsModel.self, from: data) else {
                    print("Ошибка")
                    return
                }
                complition(.success(moviewResult))
            }
    }
}
