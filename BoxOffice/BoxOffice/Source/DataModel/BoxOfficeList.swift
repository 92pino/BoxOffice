//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by JinBae Jeong on 2020/09/02.
//  Copyright © 2020 pino. All rights reserved.
//

import Foundation

struct BoxOfficeList: Codable {
  let movies: [MovieList]
}

struct MovieList: Codable {
  
  let grade: Int
  let thumb: String
  let reservationGrade: Int
  let title: String
  let reservationRate: Double
  let userRating: Double
  let date: String
  let id: String
  
  enum CodingKeys: String, CodingKey {
      case grade, title, date, thumb, id
      case reservationGrade = "reservation_grade"
      case reservationRate = "reservation_rate"
      case userRating = "user_rating"
  }
  
  var movieInfo: String {
    return "\(reservationGrade)위(\(userRating)) / \(reservationRate)%"
  }
}
