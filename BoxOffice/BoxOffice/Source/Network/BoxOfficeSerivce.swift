//
//  BoxOfficeSerivce.swift
//  BoxOffice
//
//  Created by JinBae Jeong on 2020/09/02.
//  Copyright © 2020 pino. All rights reserved.
//

import Foundation

final class BoxOfficeService: BoxOfficeServiceType {  
  
  private let baseURL = "https://connect-boxoffice.run.goorm.io/"
  
  func fetchBoxOfficeData<T>(requestType: RequestType, paramTitle: String, param: String, completionHandler: @escaping (Result<T, ServiceError>) -> Void) where T : Decodable {
    
    var urlComponent = URLComponents(string: baseURL)
    urlComponent?.path = makeParamTitle(type: requestType)
    urlComponent?.queryItems = [
      URLQueryItem(name: paramTitle, value: param)
    ]
    
    guard let url = urlComponent?.url else {
      return logger(ErrorLog.unwrap)
    }
    
    let task = URLSession.shared.dataTask(with: url) {
      (data, response, error) in
      
      guard error == nil else {
        logger(ServiceError.clientError.localizedDescription)
        return completionHandler(.failure(.clientError))
      }
      guard let header = response as? HTTPURLResponse,
        (200..<300) ~= header.statusCode else {
          logger(ServiceError.invalidStatusCode.localizedDescription)
          return completionHandler(.failure(.invalidStatusCode))
      }
      guard let data = data else {
        logger(ServiceError.noData.localizedDescription)
        return completionHandler(.failure(.noData))
      }
      
      // JSON Parsing
      if let boxOffice = try? JSONDecoder().decode(T.self, from: data) {
        logger("Networking is Success")
        logger("테스트 데이터는 정렬된 데이터가 제공되지 않아서 남기는 URL log \(url)")
        completionHandler(.success(boxOffice))
      } else {
        completionHandler(.failure(.invalidFormat))
      }
    }
    task.resume()
    
  }
  
  private func makeParamTitle(type: RequestType) -> String {
      switch type {
      case .movieList:
          return "/movies"
      case .movieDetail:
          return "/movie"
      case .movieComment:
          return "/comments"
      }
  }
  
}
