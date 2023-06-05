//
//  AlamofireService.swift
//  JRAcademyChallange
//
//  Created by Burak GÖĞÜŞ on 3.06.2023.
//
import Alamofire

struct AlamofireService {
    static let shared = AlamofireService()

    func getDefaultRequest(url:String, method: HTTPMethod, params: [String:AnyObject] = [:]) -> URLRequest {
        var request = URLRequest(url: URL(string:url)!)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 120.0
        request.method = method
        if(!params.isEmpty) {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        }
        return request
    }

    func getUrlComponent() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.rawg.io"
        urlComponents.path = "/api/games"
        urlComponents.queryItems = [URLQueryItem(name: "key", value: "3be8af6ebf124ffe81d90f514e59856c")]

        return urlComponents
    }

    func requestGetGames(completion: @escaping (Result<[Game], Error>) -> Void) {
        let request = self.getDefaultRequest(url: getUrlComponent().url!.absoluteString, method: .get)

        AF.request(request).responseDecodable(of: GameResponse.self) { response in
            switch response.result {
            case .success(let gameResponse):
                completion(
                  .success(gameResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

  func requestGetGamesWithSearch(searchText: String, completion: @escaping (Result<[Game], Error>) -> Void) {
      var urlComponents = getUrlComponent()
      let searchQuery = URLQueryItem(name: "search", value: searchText)
      urlComponents.queryItems?.append(searchQuery)
      print("AlamofireService --> \(urlComponents.url!.absoluteString) adresine istek atılıyor...")

      guard let url = urlComponents.url else {
          // Hata durumunda işlemleri yapabilirsiniz.
          return
      }

      let request = self.getDefaultRequest(url: url.absoluteString, method: .get)

      AF.request(request).responseDecodable(of: GameResponse.self) { response in
          switch response.result {
          case .success(let gameResponse):
              completion(.success(gameResponse.results))
          case .failure(let error):
              completion(.failure(error))
          }
      }
  }
  
  

}
