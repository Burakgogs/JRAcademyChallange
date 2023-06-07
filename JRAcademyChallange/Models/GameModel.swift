//
//  GameModel.swift
//  JRAcademyChallange
//
//  Created by Burak GÖĞÜŞ on 3.06.2023.
//

import Foundation
import Alamofire
// MARK: - Game
struct Game: Codable, Identifiable {
    let id: Int
    let name: String
    let genres: [Genre]?
    let gameImage: String?
    let metacritic: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case gameImage = "background_image"
        case metacritic
        case genres

    }
}

// MARK: - GameResponse
struct GameResponse: Codable {
  let results: [Game]
//  var nextGame: String = "next"
//  ? işareti 
}

// MARK: - NetworkError
struct NetworkError: Error {
    let initialError: Error
}
//struct FavoriteGame: Codable {
//    let name: String
//    let genres: [Genre]?
//    let gameImage: String?
//    let metacritic: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case name
//        case gameImage = "background_image"
//        case metacritic
//        case genres
//
//    }
//}
