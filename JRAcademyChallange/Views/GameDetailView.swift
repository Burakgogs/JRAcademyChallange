//
//  GameDetailView.swift
//  JRAcademyChallange
//
//  Created by Burak GÖĞÜŞ on 6.06.2023.
//

import Foundation
import SnapKit
import Carbon
import UIKit
import Kingfisher


struct GameDetailItem : IdentifiableComponent{
  var gameDetail: GameDetail

  var id: String {
    gameDetail.name
  }


  // MARK: - Component
  func render(in content: GameDetailView) {
    content.gameTitle.text = gameDetail.name

    if let gameImage = gameDetail.backgroundImage, let url = URL(string: gameImage) {
      let resizeProcessor = ResizingImageProcessor(referenceSize: CGSize(width: 375, height: 291))
      let imageLoadingOptions: KingfisherOptionsInfo = [
        .processor(resizeProcessor),
        .scaleFactor(UIScreen.main.scale),
        .transition(.fade(0.2))
      ]
      content.gameImage.kf.setImage(with: url, options: imageLoadingOptions)
    }
    content.gameDescription.text = gameDetail.description
    content.visitReddit.text = gameDetail.redditUrl
    content.visitWebsite.text = gameDetail.website
  }

  func referenceSize(in bounds: CGRect) -> CGSize? {
    return CGSize(width: bounds.width, height: bounds.height) // Replace 64 with the desired height value
  }

  func renderContent() -> GameDetailView {
    return GameDetailView()
  }

}

final class GameDetailView: UIView {

  var emptyTitle: UILabel = UILabel()
  var gameImage: UIImageView = UIImageView()
  var gameTitle: UILabel = UILabel()
  var gameDescription: UILabel = UILabel()
  var gameDescriptionTitle: UILabel = UILabel()
  var visitReddit: UITextView = UITextView()
  var visitWebsite: UITextView = UITextView()

  override init(frame: CGRect){
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  func setupViews () {

    self.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(gameImage)
    self.addSubview(gameDescription)
    self.addSubview(gameDescriptionTitle)
    self.addSubview(gameTitle)
    self.addSubview(visitReddit)
    self.addSubview(visitWebsite)

    gameDescriptionTitle.font = UIFont(name: "Roboto-Bold", size: 17)
    gameDescriptionTitle.textAlignment = .left
    gameDescriptionTitle.text = "Game Description"

    gameTitle.font = UIFont(name: "Roboto-Bold", size: 36)
    gameTitle.textColor = .white
    gameTitle.numberOfLines = 0
    gameTitle.textAlignment = .right


    gameDescription.font = UIFont.systemFont(ofSize: 10, weight: .light)
    gameDescription.textAlignment = .left
    gameDescription.numberOfLines = 0
    gameDescription.translatesAutoresizingMaskIntoConstraints = false

    visitReddit.font = UIFont(name: "Roboto-Bold", size: 17)
    visitReddit.textAlignment = .left

    visitWebsite.font = UIFont(name: "Roboto-Bold", size: 17)
    visitWebsite.textAlignment = .left

    visitReddit.font = UIFont(name: "Roboto-Bold", size: 17)
    visitReddit.textAlignment = .left
    visitReddit.isUserInteractionEnabled = true
    visitReddit.textColor = .black
//    let redditTapGesture = UITapGestureRecognizer(target: self, action: #selector(openReddit))
//    visitReddit.addGestureRecognizer(redditTapGesture)

    visitWebsite.font = UIFont(name: "Roboto-Bold", size: 17)
    visitWebsite.textAlignment = .left
    visitWebsite.isUserInteractionEnabled = true
    visitWebsite.textColor = .black
//    let websiteTapGesture = UITapGestureRecognizer(target: self, action: #selector(openWebsite))
//    visitWebsite.addGestureRecognizer(websiteTapGesture)

  }

    func setupConstraints() {
      // Game Image constraints
      gameImage.snp.makeConstraints { make in
        make.top.left.right.equalToSuperview()
        make.height.equalTo(291)
        make.leading.trailing.equalTo(0)
      }
      // Game Title constraints
      gameTitle.snp.makeConstraints { make in
        make.bottom.equalTo(gameImage.snp.bottom).offset(-16)
        make.left.equalToSuperview().offset(16)
        make.right.equalToSuperview().offset(-16)
      }
      // Game Description constraints
      gameDescriptionTitle.snp.makeConstraints { make in
        make.top.equalTo(gameImage.snp.bottom).offset(16)
        make.left.equalToSuperview().offset(16)
        make.right.equalToSuperview().inset(16)
      }

      // Game Description Title constraints
      gameDescription.snp.makeConstraints { make in
        make.top.equalTo(gameDescriptionTitle.snp.bottom).offset(8)
        make.left.equalToSuperview().offset(16)
        make.right.equalToSuperview().offset(-16)
      }


      // Visit Reddit constraints
      visitReddit.snp.makeConstraints { make in
        make.top.equalTo(gameDescriptionTitle.snp.bottom).offset(-16)
        make.left.equalToSuperview().offset(16)
      }

      // Visit Website constraints
      visitWebsite.snp.makeConstraints { make in
        make.top.equalTo(visitReddit.snp.bottom).offset(33)
        make.left.equalToSuperview().offset(16)
      }
    }
  }

