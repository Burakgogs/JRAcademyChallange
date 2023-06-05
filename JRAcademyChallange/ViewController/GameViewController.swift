//
//  GameViewController.swift
//  JRAcademyChallange
//
//  Created by Burak GÖĞÜŞ on 4.06.2023.
//
import UIKit
import Foundation
import Carbon
class GameViewController: UIViewController, GameViewModelDelegate {
  private let tableView: UITableView = UITableView()


  func didFetchGames() {
    render()
  }

  var viewModel: GameViewModel!
  let gameView = GameView()

    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .white

      view.addSubview(gameView)
      gameView.snp.makeConstraints { make in
        make.top.equalTo(0)
        make.leading.trailing.equalTo(0)
        make.height.equalTo(gameView.snp.height)
      }

      viewModel = GameViewModel()
      viewModel.delegate = self
      viewModel.fetchGames()

      renderer.target = tableView
      configureTableView()

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
  }
