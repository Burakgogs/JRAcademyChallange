//
//  FavoritesViewController.swift
//  JRAcademyChallange
//
//  Created by Burak GÖĞÜŞ on 4.06.2023.
//
import UIKit
import Foundation

class FavoritesViewController: UIViewController {
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
