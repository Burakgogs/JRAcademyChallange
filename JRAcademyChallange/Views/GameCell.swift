//
//  HomePageView.swift
//  JRAcademyChallange
//
//  Created by Burak GÖĞÜŞ on 3.06.2023.
//

import Foundation
import SnapKit
import Carbon
import UIKit
final class GameCell: UIView, Component {

  //  private let contentView: UIView = UIView()
  private let gameTitle: UILabel = UILabel()
  //  private let stackView = UIStackView()


  init(game: Game) {
    super.init(frame: .zero)
    setupViews(game:game)
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  // MARK: - Component

  func render(in content: GameCell) {
    // Burada herhangi bir işlem yapmanıza gerek yok
  }

  func referenceSize(in bounds: CGRect) -> CGSize? {
    return CGSize(width: bounds.width, height: 100) // Replace 64 with the desired height value
  }

  func renderContent() -> GameCell {
    return self
  }

  func setupViews (game: Game) {
    self.addSubview(gameTitle)
  
    gameTitle.textColor = .black
    gameTitle.textAlignment = .left
    gameTitle.numberOfLines = 0
    gameTitle.lineBreakMode = .byWordWrapping
    gameTitle.textColor = .black
    gameTitle.adjustsFontSizeToFitWidth = true
    gameTitle.minimumScaleFactor = 0.5
    gameTitle.baselineAdjustment = .alignCenters
    gameTitle.text = game.name
    gameTitle.font = UIFont(name: "Roboto-Bold", size: 25)
  }
  func setupConstraints(){
    gameTitle.snp.makeConstraints{ (make) in
      make.top.equalTo(16)
      make.right.equalTo(16)
      make.left.equalTo(152)
      make.bottom.equalTo(94)
      make.height.equalTo(10)
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview()
    }
  }

}

