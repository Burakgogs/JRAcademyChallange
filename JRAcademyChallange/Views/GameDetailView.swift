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


struct GameDetailItem : IdentifiableComponent {
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

    if let urlReddit = gameDetail.redditUrl {
      content.redditURL = urlReddit
    }
    if let urlWeb = gameDetail.website {
      content.webURL = urlWeb
    }

  }

  func referenceSize(in bounds: CGRect) -> CGSize? {
    return CGSize(width: bounds.width, height: bounds.height) // Replace 64 with the desired height value
  }

  func renderContent() -> GameDetailView {
    return GameDetailView()
  }

}

final class GameDetailView: UIView {
  var redditURL: String?
  var webURL: String?
  var emptyTitle: UILabel = UILabel()
  var gameImage: UIImageView = UIImageView()
  var gameTitle: UILabel = UILabel()
  var gameDescription: UILabel = UILabel()
  var gameDescriptionTitle: UILabel = UILabel()
  let website = UITextView()
  let reddit = UITextView()

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
    self.addSubview(website)
    self.addSubview(reddit)


    gameDescriptionTitle.font = UIFont(name: "Roboto-Bold", size: 17)
    gameDescriptionTitle.textAlignment = .left
    gameDescriptionTitle.text = "Game Description"

    gameTitle.font = UIFont(name: "Roboto-Bold", size: 36)
    gameTitle.textColor = .white
    gameTitle.numberOfLines = 0
    gameTitle.textAlignment = .right


    gameDescription.font = UIFont.systemFont(ofSize: 10, weight: .light)
    gameDescription.textAlignment = .left
    gameDescription.numberOfLines = 4
    gameDescription.translatesAutoresizingMaskIntoConstraints = false
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 4
    gameDescription.numberOfLines = 4

    reddit.font =  UIFont.systemFont(ofSize: 17, weight: .light)
    reddit.textAlignment = .left
    reddit.isUserInteractionEnabled = true
    reddit.textColor = .black
    reddit.isScrollEnabled = false
    reddit.isEditable = false

    website.font = UIFont.systemFont(ofSize: 17, weight: .light)
    website.textAlignment = .left
    website.isUserInteractionEnabled = true
    website.textColor = .black
    website.isScrollEnabled = false
    website.isEditable = false


    website.text = "Visit website"
    if let urlWeb = webURL {
      let attributedString = NSMutableAttributedString(string: website.text!)
        attributedString.addAttribute(.link, value: urlWeb, range: NSRange(location: 0, length: website.text!.count))
        website.attributedText = attributedString
    }
    let tapWeb = UITapGestureRecognizer(target: self, action: #selector(openWebsite))
    website.addGestureRecognizer(tapWeb)

    reddit.text = "Visit reddit"
    if let urlReddit = redditURL {
        let attributedString = NSMutableAttributedString(string: reddit.text!)
        attributedString.addAttribute(.link, value: urlReddit, range: NSRange(location: 0, length: reddit.text!.count))
        reddit.attributedText = attributedString
    }
    let tapReddit = UITapGestureRecognizer(target: self, action: #selector(openReddit))
    reddit.addGestureRecognizer(tapReddit)

  }


  @objc func openWebsite() {
      if let urlWeb = webURL, let url = URL(string: urlWeb) {
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
  }

  @objc func openReddit() {
      if let urlReddit = redditURL, let url = URL(string: urlReddit) {
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
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
        make.height.equalTo(81)
      }


      // Visit Reddit constraints
      reddit.snp.makeConstraints { make in
//        make.bottom.equalTo(16)
        make.top.equalTo(gameDescription.snp.bottom).offset(16)
        make.left.equalToSuperview().offset(16)
        make.right.equalToSuperview().offset(16)

      }

      // Visit Website constraints
      website.snp.makeConstraints { make in
        make.top.equalTo(reddit.snp.bottom).offset(33)
        make.left.equalTo(16)
//        make.right.equalToSuperview().offset(16)
//
      }
    }
  }

