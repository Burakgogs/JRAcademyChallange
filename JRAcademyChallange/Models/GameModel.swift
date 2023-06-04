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
      case id = "id"
      case name = "name"
      case released = "released"
      case backgroundImage = "backgroundImage"
      case rating = "rating"
    }
}

// MARK: - Network Error
struct NetworkError: Error {
  let initialError: AFError
}

struct GameResponse: Codable {
    let results: [Game]
}
