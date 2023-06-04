//
//  HomePageView.swift
//  JRAcademyChallange
//
//  Created by Burak GÖĞÜŞ on 3.06.2023.
//

import Foundation
import SnapKit

final class GameView : UIViewController {

  private let contentView: UIView = UIView()
  private let gameTitle: UILabel = UILabel()
  private let stackView = UIStackView()


  override func viewDidLoad() {
    super.viewDidLoad()
    configure()

  }
  func configure() {
    view.addSubview(stackView)
    stackView.addSubview(contentView)
    contentView.addSubview(gameTitle)

    stackView.backgroundColor = .blue
    contentView.backgroundColor = .white

    stackView.axis = .vertical
    stackView.contentMode = .scaleToFill
    stackView.alignment = .fill
    stackView.spacing = 0
    stackView.distribution = .fill


    stackView.snp.makeConstraints{ (make) in
      make.top.equalTo(100)
      make.bottom.equalToSuperview().offset(-83)
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
    }

    contentView.snp.makeConstraints{ (make) in
      make.width.equalTo(136)
      make.height.equalTo(375)
      make.right.equalTo(0)
      make.left.equalTo(0)
      make.top.equalTo(120)

//      make.leading.equalToSuperview()
//      make.trailing.equalToSuperview()
    }

    gameTitle.textColor = .black
    gameTitle.textAlignment = .left
    gameTitle.numberOfLines = 0
    gameTitle.lineBreakMode = .byWordWrapping
    gameTitle.textColor = .black
    gameTitle.adjustsFontSizeToFitWidth = true
    gameTitle.minimumScaleFactor = 0.5
    gameTitle.baselineAdjustment = .alignCenters
    gameTitle.text = "Favorites"
    gameTitle.font = UIFont(name: "Roboto-Bold", size: 25)

    gameTitle.snp.makeConstraints{ (make) in
      make.top.equalTo(contentView).offset(16)
      make.right.equalTo(contentView).offset(16)
      make.left.equalTo(152)
      make.bottom.equalTo(contentView).offset(94)
    }

  }

}
