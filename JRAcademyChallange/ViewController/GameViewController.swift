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

    }

  private let renderer = Renderer(
      adapter: UITableViewAdapter(),
      updater: UITableViewUpdater()
  )

  func render() {
    var cellNode: [CellNode] = []
    for game in viewModel.games {
      let gameNode = CellNode(GameItem(game:game))
      cellNode.append(gameNode)
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
//      tableView.tableFooterView = LoadingFooterView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

      if let searchText = searchBar.text {
       
        print("Search text: \(searchText)")
        if searchText.count >= 3 {
          viewModel.searchGames(text: searchText)
          renderFindGame()

          func renderFindGame() {
            var cellNode: [CellNode] = []
            for game in viewModel.findgames {
              let gameNode = CellNode(GameItem(game:game))
              cellNode.append(gameNode)
            }
            let gameSection = Section(id: "gameSection", cells: cellNode)
            renderer.render(gameSection)
          }
        }else {
            var cellNode: [CellNode] = []
              let emptyNode = CellNode(EmptyItem())
              cellNode.append(emptyNode)
            let emptySection = Section(id: "gameSection", cells: cellNode)
            renderer.render(emptySection)
        }
      }
      searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {//cancel butona tıkladığımda
      searchBar.text = ""
      searchBar.resignFirstResponder()
      searchBar.showsCancelButton = false
      viewModel.fetchGames()
      didFetchGames()
    }

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {//Tıkladığım anda
    searchBar.showsCancelButton = true
      var cellNode: [CellNode] = []
        let emptyNode = CellNode(EmptyItem())
        cellNode.append(emptyNode)
      let emptySection = Section(id: "gameSection2", cells: cellNode)
      renderer.render(emptySection)
    }

  func searchbar(_ searchBar: UISearchBar) {
      var cellNode: [CellNode] = []
        let emptyNode = CellNode(EmptyItem())
        cellNode.append(emptyNode)
      let emptySection = Section(id: "gameSection2", cells: cellNode)
      renderer.render(emptySection)
    }
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//    searchBar.showsCancelButton = true
//    if  searchText.isEmpty{
//      viewModel.fetchGames()
//    }
  }
  

}
