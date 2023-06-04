//
//  GameViewController.swift
//  JRAcademyChallange
//
//  Created by Burak GÖĞÜŞ on 3.06.2023.
//
//first
import UIKit
import SnapKit
import Carbon
final class GameViewController: UIViewController {
  private var customTabBarController: MainTabBarController! = MainTabBarController()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    customTabBarController = MainTabBarController()
    addChild(customTabBarController)
    view.addSubview(customTabBarController.view)

    customTabBarController.view.snp.makeConstraints { make in
        make.edges.equalToSuperview()
    }

    customTabBarController.didMove(toParent: self)
  }



  class MainTabBarController: UITabBarController {
      override func viewDidLoad() {
          super.viewDidLoad()

          let tabOneVC = TabOneViewController()
          tabOneVC.tabBarItem = UITabBarItem(title: "Games", image:  UIImage(named: "GameIcon"), tag: 0)

          let tabTwoVC = TabTwoViewController()
          tabTwoVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "FavoriteIcon"), tag: 1)

          viewControllers = [tabOneVC, tabTwoVC]
      }
  }
  class TabOneViewController: UIViewController {
    let labelTitle: UILabel = UILabel()
    let navigationBar = UINavigationBar()

    let searchBar = UISearchBar()
    let stackView = UIStackView()
    let tableView = UITableView()
    let emptyGame = UILabel()

      override func viewDidLoad() {
          super.viewDidLoad()

          view.backgroundColor = .white

          let label = UILabel()
          label.text = "Tab One"
          label.textAlignment = .center
          label.font = UIFont.boldSystemFont(ofSize: 24)
          view.addSubview(label)

          label.snp.makeConstraints { make in
              make.center.equalToSuperview()
          }
        configure()
      }

    func configure() {
      view.addSubview(navigationBar)
      navigationBar.addSubview(labelTitle)
      view.addSubview(stackView)
      stackView.addArrangedSubview(searchBar)
      stackView.addArrangedSubview(tableView)
      tableView.addSubview(emptyGame)




      navigationBar.layer.cornerRadius = 0
      navigationBar.tintColor = .white
      navigationBar.topItem?.title = "Navigation Bar"
      navigationBar.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 0.92)

      navigationBar.snp.makeConstraints { make in
                make.height.equalTo(140)
                make.width.equalTo(375)
                make.left.equalToSuperview()
                make.top.equalToSuperview()
                make.right.equalToSuperview()
            }


      labelTitle.textColor = .black
      labelTitle.textAlignment = .left
      labelTitle.numberOfLines = 0
      labelTitle.lineBreakMode = .byWordWrapping
      labelTitle.textColor = .black
      labelTitle.adjustsFontSizeToFitWidth = true
      labelTitle.minimumScaleFactor = 0.5
      labelTitle.baselineAdjustment = .alignCenters
      labelTitle.text = "Games"
      labelTitle.font = UIFont(name: "Roboto-Bold", size: 34)

      labelTitle.snp.makeConstraints{ (make) in
        make.top.equalTo(navigationBar).offset(90)
        make.left.equalToSuperview().offset(16)
        make.right.equalToSuperview().offset(250)
        make.bottom.equalTo(navigationBar).offset(-9)
        make.height.equalTo(41)
        make.width.equalTo(109)

      }


      stackView.axis = .vertical
      stackView.contentMode = .scaleToFill
      stackView.alignment = .fill
      stackView.spacing = 0
      stackView.distribution = .fill
      stackView.backgroundColor = .gray

      stackView.snp.makeConstraints{ (make) in
        make.top.equalTo(navigationBar.snp.bottom).offset(2)
        make.bottom.equalToSuperview().offset(-83)
        make.leading.equalToSuperview()
        make.trailing.equalToSuperview()
      }

      searchBar.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 0.92)
      searchBar.layer.cornerRadius = 10
      searchBar.placeholder = "Search for the games"
      searchBar.searchTextField.font = UIFont.systemFont(ofSize: 17)
      searchBar.snp.makeConstraints { make in

      }


      emptyGame.textColor = .black
      emptyGame.textAlignment = .center
      emptyGame.numberOfLines = 0
      emptyGame.lineBreakMode = .byWordWrapping
      emptyGame.textColor = .black
      emptyGame.adjustsFontSizeToFitWidth = true
      emptyGame.minimumScaleFactor = 0.5
      emptyGame.baselineAdjustment = .alignCenters
      emptyGame.text = "No game has been searched."
      emptyGame.font = UIFont(name: "Roboto-Bold", size: 18)

      emptyGame.snp.makeConstraints{ (make) in
        make.top.equalTo(tableView).offset(37.5)
        make.centerX.equalToSuperview()

      }

    }
  }

  class TabTwoViewController: UIViewController {
    let labelTitle: UILabel = UILabel()
    let navigationBar = UINavigationBar()

    let stackView = UIStackView()
    let tableView = UITableView()
    let emptyFavorite = UILabel()

    override func viewDidLoad() {
      super.viewDidLoad()

      view.backgroundColor = .white

      configure()

    }

    func configure() {

      view.addSubview(navigationBar)
      navigationBar.addSubview(labelTitle)
      view.addSubview(stackView)
     
      stackView.addArrangedSubview(tableView)
      tableView.addSubview(emptyFavorite)

      navigationBar.layer.cornerRadius = 0
      navigationBar.tintColor = .white
      navigationBar.topItem?.title = "Navigation Bar"
      navigationBar.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 0.92)

      navigationBar.snp.makeConstraints { make in
                make.height.equalTo(140)
                make.width.equalTo(375)
                make.left.equalToSuperview()
                make.top.equalToSuperview()
                make.right.equalToSuperview()
            }


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

      labelTitle.snp.makeConstraints{ (make) in
        make.top.equalTo(navigationBar).offset(90)
        make.left.equalToSuperview().offset(16)
        make.right.equalToSuperview().offset(250)
        make.bottom.equalTo(navigationBar).offset(-9)
        make.height.equalTo(41)
        make.width.equalTo(109)

      }
      stackView.axis = .vertical
      stackView.contentMode = .scaleToFill
      stackView.alignment = .fill
      stackView.spacing = 0
      stackView.distribution = .fill
      stackView.backgroundColor = .gray

      stackView.snp.makeConstraints{ (make) in
        make.top.equalTo(navigationBar.snp.bottom).offset(2)
        make.bottom.equalToSuperview().offset(-83)
        make.leading.equalToSuperview()
        make.trailing.equalToSuperview()
      }




      emptyFavorite.textColor = .black
      emptyFavorite.textAlignment = .center
      emptyFavorite.numberOfLines = 0
      emptyFavorite.lineBreakMode = .byWordWrapping
      emptyFavorite.textColor = .black
      emptyFavorite.adjustsFontSizeToFitWidth = true
      emptyFavorite.minimumScaleFactor = 0.5
      emptyFavorite.baselineAdjustment = .alignCenters
      emptyFavorite.text = "No game has been searched."
      emptyFavorite.font = UIFont(name: "Roboto-Bold", size: 18)

      emptyFavorite.snp.makeConstraints{ (make) in
        make.top.equalTo(tableView).offset(37.5)
        make.centerX.equalToSuperview()

      }

    }
  }

}
