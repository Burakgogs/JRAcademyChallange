//
//  FavoritesViewController.swift
//  JRAcademyChallange
//
//  Created by Burak GÖĞÜŞ on 4.06.2023.
//

import UIKit
import Foundation
import Carbon
import CoreData

class FavouritesViewController: UIViewController, GameViewModelDelegate {
  func didFetchGames() {}
  func searchGame() { }
  func didFetchMoreGames() { }
  func getDetailGames() {
    render()
  }
  private let tableView: UITableView = UITableView()
  var gameID: Int?
  let labelTitle: UILabel = UILabel()
  let navigationBar = UINavigationBar()
  var favouritesGames: [Int] = []
  var managedObjectContext: NSManagedObjectContext!

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    renderer.adapter.favouritesController = self
    setupUI()
    configureTableView()
    setupConstraints()
    //      tableView.addSubview(emptyFavorite)
    renderer.target = tableView
    render()
  
  }
  func setupUI(){
    view.addSubview(navigationBar)
    navigationBar.addSubview(labelTitle)
    view.addSubview(tableView)

    tableView.snp.makeConstraints { make in
      make.top.equalTo(navigationBar.snp.bottom)
         make.leading.equalTo(0)
         make.trailing.equalTo(0)
         make.bottom.equalToSuperview().offset(-83)
     }
      tableView.separatorStyle = .none
      tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)

    navigationBar.layer.cornerRadius = 0
    navigationBar.tintColor = .white
    navigationBar.topItem?.title = "Navigation Bar"
    navigationBar.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 0.92)

    labelTitle.textColor = .black
    labelTitle.textAlignment = .left
    labelTitle.numberOfLines = 0
    labelTitle.lineBreakMode = .byWordWrapping
    labelTitle.textColor = .black
    labelTitle.adjustsFontSizeToFitWidth = true
    labelTitle.minimumScaleFactor = 0.5
    labelTitle.baselineAdjustment = .alignCenters
    labelTitle.text = "Favorites"
    labelTitle.font = UIFont(name: "Roboto-Bold", size: 34)
  }
  func setupConstraints(){
    labelTitle.snp.makeConstraints{ (make) in
      make.top.equalTo(navigationBar).offset(90)
      make.left.equalTo(16)
      make.right.equalTo(250)
      make.bottom.equalTo(navigationBar).offset(-9)
      make.height.equalTo(41)
      make.width.equalTo(109)
    }
    navigationBar.snp.makeConstraints { make in
      make.height.equalTo(140)
//      make.width.equalTo(375)
      make.left.equalToSuperview()
      make.top.equalToSuperview()
      make.right.equalToSuperview()
    }

  }

    override func viewWillAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         render()
     }


  private let renderer = Renderer(
      adapter: FavouriteAdapter(),
      updater: UITableViewUpdater()
  )

  func render() {

    var cellNode: [CellNode] = []


    if let favorites = getFavourites() {

      if favorites.isEmpty{
        let emptyNode = CellNode(id: "EmptyCell",EmptyItem())
        cellNode.append(emptyNode)
      }else{
        for favorite in favorites {
          let genresString = favorite.value(forKey: "genres") as? String
          let genresArray = genresString?.components(separatedBy: ",")
          let genreObjects = genresArray?.compactMap {
            Genre(name: $0.trimmingCharacters(in: .whitespacesAndNewlines))
          }
          if let name = favorite.value(forKey: "name") as? String,
             let image = favorite.value(forKey: "image") as? String,
             let gameID = favorite.value(forKey: "gameid") as? Int,
             let metacritic = favorite.value(forKey: "metacritic") as? Int {

            let game = Game(id: gameID, name: name, genres: genreObjects, gameImage: image, metacritic: metacritic)
            let gameNode = CellNode(id: String(gameID), GameItem(game: game))
            print("---------->",game)
            favouritesGames.append(gameID)
            cellNode.append(gameNode)
          }
        }
        let gameSection = Section(id: "gameSection", cells: cellNode)
        renderer.render(gameSection)
      }

    }
}
  func configureTableView() {


    }


  func getFavourites() -> [NSManagedObject]? {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return nil
      }

      let managedContext = appDelegate.persistentCheckContainer.viewContext
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favourite")

      do {
          let results = try managedContext.fetch(fetchRequest)
          return results
      } catch let error as NSError {
          print("Favori alınırken hata oluştu: \(error), \(error.userInfo)")
          return nil
      }
  }





}

