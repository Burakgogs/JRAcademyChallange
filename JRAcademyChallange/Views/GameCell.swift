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


struct GameItem : IdentifiableComponent{
  var title: String
  var id: String {
      title
    }

  // MARK: - Component
  func render(in content: GameCell) {
    content.gameTitle.text = title

  }

  func referenceSize(in bounds: CGRect) -> CGSize? {
    return CGSize(width: bounds.width, height: 100) // Replace 64 with the desired height value
  }

  func renderContent() -> GameCell {
    return GameCell()

  }

}

final class GameCell: UIView{

  //  private let contentView: UIView = UIView()
  let gameTitle: UILabel = UILabel()
  //  private let stackView = UIStackView()
 

  override init(frame: CGRect){
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  

  func setupViews () {
    self.addSubview(gameTitle)
  
    gameTitle.textColor = .black
    gameTitle.textAlignment = .left
    gameTitle.numberOfLines = 0
    gameTitle.lineBreakMode = .byWordWrapping
    gameTitle.textColor = .black
    gameTitle.adjustsFontSizeToFitWidth = true
    gameTitle.minimumScaleFactor = 0.5
    gameTitle.baselineAdjustment = .alignCenters

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

