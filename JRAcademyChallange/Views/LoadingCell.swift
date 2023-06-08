//
//  LoadingCell.swift
//  JRAcademyChallange
//
//  Created by Burak GÖĞÜŞ on 8.06.2023.
//
//
//import Foundation
//
//import Foundation
//import SnapKit
//import Carbon
//import UIKit
//
//struct LoadingItem : IdentifiableComponent{
//
//  var id = 1
//
//  // MARK: - Component
//  func render(in content: EmptyView) {
//  }
//
//  func referenceSize(in bounds: CGRect) -> CGSize? {
//    return CGSize(width: bounds.width, height: 136) // Replace 64 with the desired height value
//  }
//
//  func renderContent() -> EmptyView {
//    return EmptyView()
//  }
//
//}
//
//final class LoadingCell: UIView {
//
//
//
//  var loadingBar: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
//
//
//
//
//  override init(frame: CGRect){
//    super.init(frame: frame)
//    setupViews()
//    setupConstraints()
//  }
//
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//
//
//  func setupViews () {
//
//    self.addSubview(loadingBar)
//
//    loadingBar.color = .blue
//      loadingBar.startAnimating()
//
//
//  }
//
//
//  func setupConstraints(){
//
//
//    loadingBar.snp.makeConstraints{ (make) in
//      make.top.equalToSuperview().offset(37.5)
//      make.left.equalToSuperview().offset(0)
//      make.right.equalToSuperview().offset(0)
//      make.centerX.equalToSuperview()
//
//    }
//  }
//}
