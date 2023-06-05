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
import Kingfisher

struct GameItem : IdentifiableComponent{
  var game: Game

  var id: String {
    game.name
    }

  // MARK: - Component
  func render(in content: GameCell) {
    content.gameTitle.text = game.name
    content.metacritic.text = "metacritic:"
    if let metacritic = game.metacritic { content.metaScore.text = String(metacritic)}

    if let genres = game.genres {
        let genreNames = genres.compactMap { $0.name }
        if !genreNames.isEmpty {
          let joinedGenreNames = genreNames.joined(separator: ", ")
          content.genreTitle.text = joinedGenreNames
        } else {
          content.genreTitle.text = "N/A"
        }
      }
    if let gameImage = game.gameImage {
      if let url = URL(string: gameImage) {
      let resizeProcessor = ResizingImageProcessor(referenceSize: CGSize(width: 120, height: 104))
      let imageLoadingOptions: KingfisherOptionsInfo = [
          .processor(resizeProcessor),
          .scaleFactor(UIScreen.main.scale),
          .transition(.fade(0.2)),
      ]
        content.imageView.kf.setImage(with: url, options: imageLoadingOptions)
      }
    }
  }

  func referenceSize(in bounds: CGRect) -> CGSize? {
    return CGSize(width: bounds.width, height: 136) // Replace 64 with the desired height value
  }

  func renderContent() -> GameCell {
    return GameCell()
  }

}

final class GameCell: UIView {


  var gameTitle: UILabel = UILabel()
  var metacritic: UILabel = UILabel()
  var metaScore: UILabel = UILabel()
  var genreTitle: UILabel = UILabel()
  var imageView = UIImageView()
  var imageURL = String()


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
    self.addSubview(metacritic)
    self.addSubview(metaScore)
    self.addSubview(genreTitle)
    self.addSubview(imageView)

    gameTitle.textColor = .black
    gameTitle.textAlignment = .left
    gameTitle.numberOfLines = 0
    gameTitle.lineBreakMode = .byWordWrapping
    gameTitle.adjustsFontSizeToFitWidth = true
    gameTitle.minimumScaleFactor = 0.5
    gameTitle.baselineAdjustment = .alignBaselines
    gameTitle.font = UIFont(name: "Roboto-Bold", size: 20)

    metacritic.font = UIFont(name: "Roboto-Bold", size: 14)
    metacritic.textColor = .black

    metaScore.font = UIFont(name: "Roboto-Bold", size: 18)
    metaScore.textColor = UIColor(hex: "#D80000")

    genreTitle.font = UIFont.systemFont(ofSize: 13)  

    genreTitle.textColor = UIColor(hex: "#8A8A8F")

  }


  func setupConstraints(){

    gameTitle.snp.makeConstraints{ (make) in
      make.top.equalToSuperview().offset(16)
      make.right.equalTo(-16)
      make.left.equalTo(152)
    }
    metacritic.snp.makeConstraints{ (make) in
      make.top.equalTo(84)
      make.right.equalTo(-147)
      make.left.equalTo(152)
//      make.bottom.equalTo(36)

    }
    metaScore.snp.makeConstraints{ (make) in
      make.top.equalTo(metacritic)
      make.right.equalTo(-121)
      make.left.equalTo(228)
      make.bottom.equalTo(metacritic)
    }
    genreTitle.snp.makeConstraints{ (make) in
      make.top.equalTo(metacritic.snp.bottom).offset(8)
      make.right.equalTo(-16)
      make.left.equalTo(152)
//      make.bottom.equalToSuperview().offset(12)
    }
    imageView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(16)
      make.left.equalTo(16)
      make.right.equalTo(gameTitle.snp.left).offset(-16)
      make.bottom.equalToSuperview().offset(16)
      make.height.equalTo(104)
      make.width.equalTo(120)
    }
  }
}
extension UIColor {
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        if hexString.count != 6 {
            self.init(white: 1.0, alpha: 1.0)
            return
        }
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
