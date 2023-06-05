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
    let released: String?
    let backgroundImage: String?
    let rating: Double

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case rating

    }
}

// MARK: - GameResponse
struct GameResponse: Codable {
    let results: [Game]
}

// MARK: - NetworkError
struct NetworkError: Error {
    let initialError: Error
}
