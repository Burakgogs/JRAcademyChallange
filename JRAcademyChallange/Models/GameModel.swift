//
//  GameModel.swift
//  JRAcademyChallange
//
//  Created by Burak GÖĞÜŞ on 3.06.2023.
//

import Foundation
import Alamofire

// MARK: - GameResponse
struct Game: Codable, Identifiable {
    let id: Int?
    let name: String?
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

// MARK: - Network Error
struct NetworkError: Error {
  let initialError: AFError
}

struct GameResponse: Codable {
    let results: [Game]
}
