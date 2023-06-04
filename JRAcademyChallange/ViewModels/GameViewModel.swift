//
//  GameViewModel.swift
//  JRAcademyChallange
//
//  Created by Burak GÖĞÜŞ on 3.06.2023.
//
import UIKit
import Alamofire
import Foundation

  protocol GameViewModelDelegate: AnyObject {
    func didFetchGames(games: [Game])
  }

  class GameViewModel {
      weak var delegate: GameViewModelDelegate?
      private var games: [Game] = []

      func fetchGames() {
        AlamofireService.shared.requestGetGames { result in
                    switch result {
                    case .success(let games):
                        self.delegate?.didFetchGames(games: games)
                    case .failure(let error):
                        print("Error fetching games: \(error)")
                    }
          }
      }

      func getGame(at index: Int) -> Game? {
          guard index >= 0 && index < games.count else { return nil }
          return games[index]
      }
  }

