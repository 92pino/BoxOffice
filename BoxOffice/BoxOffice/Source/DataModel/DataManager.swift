//
//  DataManager.swift
//  BoxOffice
//
//  Created by JinBae Jeong on 2020/09/02.
//  Copyright © 2020 pino. All rights reserved.
//

import Foundation

final class DataManager {
  
  static let shared = DataManager()
  private init() {}
  
  let service: BoxOfficeServiceType = BoxOfficeService()
  
}
