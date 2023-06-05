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
    func didFetchGames()
    func searchGame()
    func didFetchMoreGames()
  }

class GameViewModel {
  weak var delegate: GameViewModelDelegate?
  var games: [Game] = []
  var findgames: [Game] = []

  func fetchGames() {
    AlamofireService.shared.requestGetGames { result in
      switch result {
      case .success(let games):
        self.games = games
        self.delegate?.didFetchGames()
      case .failure(let error):
        print("Error fetching games: \(error)")
      }
    }
  }
    func searchGames(text: String) {
      AlamofireService.shared.requestGetGamesWithSearch(searchText: text) { result in
        switch result {
        case .success(let games):
          self.games = games
          self.delegate?.searchGame()
        case .failure(let error):
          print("Error fetching games: \(error)")
        }
      }
    }
  func fetchGetMoreGames(nextPage: String) {
    AlamofireService.shared.requestGetGames { result in
      switch result {
      case .success(let games):
        self.games = games
        self.delegate?.didFetchMoreGames()
      case .failure(let error):
        print("Error fetching games: \(error)")
      }
    }
  }
}
