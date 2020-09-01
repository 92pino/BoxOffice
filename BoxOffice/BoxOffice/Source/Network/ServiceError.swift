//
//  ServiceError.swift
//  BoxOffice
//
//  Created by JinBae Jeong on 2020/09/02.
//  Copyright © 2020 pino. All rights reserved.
//

import Foundation

enum ServiceError: Error {
  case clientError
  case invalidStatusCode
  case noData
  case invalidFormat
}
