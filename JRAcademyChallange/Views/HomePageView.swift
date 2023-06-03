//
//  HomePageView.swift
//  JRAcademyChallange
//
//  Created by Burak GÖĞÜŞ on 3.06.2023.
//

import Foundation
import SnapKit

final class HomePageView : UIViewController {

  private let labelTitle: UILabel = UILabel()
  private let box: UIView = UIView()
  private let indicatior: UIActivityIndicatorView = UIActivityIndicatorView()



  override func viewDidLoad() {
    super.viewDidLoad()
    configure()

  }
  func configure() {
    view.addSubview(labelTitle)
    view.addSubview(box)
    view.addSubview(indicatior)
    box.backgroundColor = .red


    labelTitle.snp.makeConstraints{ (make) in
      make.top.equalToSuperview().offset(90)
      make.left.equalToSuperview().offset(16)
      make.height.equalTo(41)
      make.width.equalTo(109)
    }


  }

}
