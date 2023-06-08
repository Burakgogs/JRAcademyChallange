//
//  GameViewController.swift
//  JRAcademyChallange
//
//  Created by Burak GÖĞÜŞ on 4.06.2023.
//
import UIKit
import Foundation
import Carbon
class GameViewController: UIViewController, GameViewModelDelegate, UISearchBarDelegate {
  func getDetailGames() {}
  
  func didFetchMoreGames() {
   render()
  }
  func searchGame() {
    render()
  }
  func didFetchGames() {
    render()
  }
  private let tableView: UITableView = UITableView()


  var viewModel: GameViewModel = GameViewModel()
  let gameView = GameView()

  var cell: GameCell = GameCell()
    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .white

      view.addSubview(gameView)
      gameView.snp.makeConstraints { make in
        make.top.equalTo(0)
        make.leading.trailing.equalTo(0)
        make.height.equalTo(gameView.snp.height)
      }

      viewModel.delegate = self
      viewModel.fetchGames()
      renderer.target = tableView
      configureTableView()
      gameView.searchBar.delegate = self
      NotificationCenter.default.addObserver(self, selector: #selector(getNextPage(notification:)), name: NSNotification.Name("getMoreGame"), object: nil)

    }
  @objc func getNextPage(notification: Notification) {
        if let nextPage = viewModel.nextPage {
          if !viewModel.games.isEmpty {
            viewModel.fetchMoreGames(nextPage:nextPage)
          }
        }
    }
  private let renderer = Renderer(
      adapter: CustomTableViewAdapter(),
      updater: UITableViewUpdater()
  )

  func render() {
    var cellNode: [CellNode] = []

    if viewModel.games.isEmpty {
       let emptyNode = CellNode(id: "EmptyCell",EmptyItem())
      cellNode.append(emptyNode)
    } else {
      for game in viewModel.games {
        let gameNode = CellNode(id: "GameCell",GameItem(game:game))
        cellNode.append(gameNode)
      }
    }
    let gameSection = Section(id: "gameSection", cells: cellNode)
    renderer.render(gameSection)
  }


  func configureTableView() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.top.equalTo(gameView.searchBar.snp.bottom)
         make.leading.equalTo(0)
         make.trailing.equalTo(0)
         make.bottom.equalToSuperview().offset(-83)
     }
      tableView.separatorStyle = .none
      tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      viewModel.games.removeAll()

      if let searchText = searchBar.text {

        print("Search text: \(searchText)")
        if searchText.count >= 3 {
          viewModel.searchGames(text: searchText)
        }
      }
      searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {//cancel butona tıkladığımda
      searchBar.text = ""
      searchBar.resignFirstResponder()
      searchBar.showsCancelButton = false
      viewModel.games.removeAll()
      viewModel.fetchGames()
      didFetchGames()
    }

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {//Tıkladığım anda
    searchBar.showsCancelButton = true
    viewModel.games.removeAll()
    render()
    }

  func searchbar(_ searchBar: UISearchBar) {
    viewModel.games.removeAll()
    render()
    }
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    


  }
  

}
