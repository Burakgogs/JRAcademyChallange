//
//  GameDetailViewController.swift
//  JRAcademyChallange
//
//  Created by Burak GÖĞÜŞ on 6.06.2023.
//

import UIKit
import Foundation
import Carbon
import CoreData

class GameDetailViewController: UIViewController, GameViewModelDelegate, UISearchBarDelegate {
  func getDetailGames() {
    render()
    checkFavourites()
  }
  func didFetchMoreGames() {}
  func searchGame() {}
  func didFetchGames() {}

  private let tableView: UITableView = UITableView()

  var viewModel: GameViewModel = GameViewModel()
  var gameID: Int?
  var managedObjectContext: NSManagedObjectContext!


    override func viewDidLoad() {

      super.viewDidLoad()
      view.backgroundColor = .white
      viewModel.delegate = self
      tableView.isScrollEnabled = false
      renderer.target = tableView
      configureTableView()
      let appDelegate = UIApplication.shared.delegate as! AppDelegate

              managedObjectContext = appDelegate.persistentContainer.viewContext
    }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillAppear(animated)
    checkFavourites()
  }


  func checkFavourites(){

    let shareButton = UIBarButtonItem(title: "Favourite", style: .plain, target: self, action: #selector(FavouriteButtonTapped))
        navigationItem.rightBarButtonItem = shareButton

    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        var checkManagedContext = appDelegate.persistentContainer.viewContext

    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourite")
    fetchRequest.predicate = NSPredicate(format: "gameid == %d", viewModel.gamesDetail?.id ?? 0)
    do {
        let results = try checkManagedContext.fetch(fetchRequest)

      if !results.isEmpty {
          navigationItem.rightBarButtonItem?.title = "Favourited"
            return
        }
    } catch let error as NSError {
        print("Favori eklenme hatası: \(error), \(error.userInfo)")
    }
    render()
    var isEmpty: Bool {

          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourite")
          do {
              let count = try checkManagedContext.count(for: fetchRequest)
              return count == 0
          } catch {
              return true
          }
      }
  }
  @objc func FavouriteButtonTapped() {

    var isEmpty: Bool {
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
          do {
              let count = try managedObjectContext.count(for: fetchRequest)
              return count == 0
          } catch {
              return true
          }
      }
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
    var managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Favourite", in: managedContext) else {
          return
        }
        var combinedGenres: String?
        if let genres = viewModel.gamesDetail?.genres {
          let genreNames = genres.compactMap { $0.name }
          combinedGenres = genreNames.joined(separator: ", ")
        }
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourite")

    fetchRequest.predicate = NSPredicate(format: "name == %@ AND image == %@ AND metacritic == %d AND genres == %@ AND gameid == %d", viewModel.gamesDetail?.name ?? "", viewModel.gamesDetail?.backgroundImage ?? "", viewModel.gamesDetail?.metacritic ?? 0, combinedGenres ?? "",viewModel.gamesDetail?.id ?? 0)
        do {
          let results = try managedContext.fetch(fetchRequest)

        } catch let error as NSError {
          print("Favori hatası: \(error), \(error.userInfo)")
        }
        let favorite = NSManagedObject(entity: entity, insertInto: managedContext)
        favorite.setValue(viewModel.gamesDetail?.id, forKey: "gameid")
        favorite.setValue(viewModel.gamesDetail?.name, forKey: "name")
        favorite.setValue(viewModel.gamesDetail?.backgroundImage, forKey: "image")
        favorite.setValue(viewModel.gamesDetail?.metacritic, forKey: "metacritic")
        favorite.setValue(combinedGenres, forKey: "genres")
        do {
          try managedContext.save()
          navigationItem.rightBarButtonItem?.title = "Favourited"
        } catch let error as NSError {
          print("Favori kaydedilirken hata oluştu: \(error), \(error.userInfo)")
        }
      }

  func getDetailGame(gameID:Int) {
    viewModel.getDetailGames(gameID: gameID)
  }
  private let renderer = Renderer(
      adapter: UITableViewAdapter(),
      updater: UITableViewUpdater()
  )

  func render() {
    var cellNode: [CellNode] = []

    let gameDetailNode = CellNode(GameDetailItem(
      gameDetail: GameDetail(
        id: viewModel.gamesDetail?.id ?? 0,
        name: viewModel.gamesDetail?.name ?? "",
        backgroundImage: viewModel.gamesDetail?.backgroundImage ?? "",
        description: viewModel.gamesDetail?.description ?? "", redditUrl: viewModel.gamesDetail?.redditUrl ?? "",
        website: viewModel.gamesDetail?.website ?? "",
        genres: viewModel.gamesDetail?.genres ?? [],
        metacritic: viewModel.gamesDetail?.metacritic ?? 0
      )
    ))

      cellNode.append(gameDetailNode)

    let gameSection = Section(id: "gameSection", cells: cellNode)
    renderer.render(gameSection)
  }
  func configureTableView() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.top.equalTo(0)
         make.leading.equalTo(0)
         make.trailing.equalTo(0)
         make.bottom.equalToSuperview().offset(0)
     }
      tableView.separatorStyle = .none
      tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
//      tableView.tableFooterView = LoadingFooterView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))

    }







}
