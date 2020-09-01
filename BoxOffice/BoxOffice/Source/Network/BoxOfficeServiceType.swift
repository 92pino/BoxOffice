//
//  BoxOfficeServiceType.swift
//  BoxOffice
//
//  Created by JinBae Jeong on 2020/09/02.
//  Copyright © 2020 pino. All rights reserved.
//

import Foundation

enum RequestType {
    case movieList
    case movieDetail
    case movieComment
}

protocol BoxOfficeServiceType {
  
  func fetchBoxOfficeData(
    requestType: RequestType,
    paramTitle: String,
    param: String,
    completionHandler: @escaping (Result<BoxOfficeList, ServiceError>) -> Void
  )
  
}
