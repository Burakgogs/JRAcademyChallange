//
//  AlamofireService.swift
//  JRAcademyChallange
//
//  Created by Burak GÖĞÜŞ on 3.06.2023.
//

import Foundation
import Alamofire
struct AlamofireService {
  static let shared = AlamofireService()

  func getDefaultRequest(url:String,
                         method: HTTPMethod,
                         params: [String:AnyObject] = [:]) -> URLRequest {
    var request = URLRequest(url: URL(string:url)!)
    request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    request.timeoutInterval = 120.0
    request.method = method
    if(!params.isEmpty){
      request.httpBody = try? JSONSerialization.data(withJSONObject: params)
    }
    return request

  }
  func getUrlComponent() -> URLComponents {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.rawg.io/api"
    urlComponents.path = "games?key=3be8af6ebf124ffe81d90f514e59856c"
    print("AlamofireService -->\(urlComponents.string!)adresine istek atılıyor...")
    return urlComponents
  }
  func requestGetGames() -> DataRequest {
    let request = self.getDefaultRequest(url: self.getUrlComponent().string!, method: .get)
    return AF.request(request)
  }
}
