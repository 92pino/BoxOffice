//
//  ErrorLog.swift
//  BoxOffice
//
//  Created by JinBae Jeong on 2020/09/02.
//  Copyright © 2020 pino. All rights reserved.
//

import Foundation

enum ErrorLog {
  static let layout = "Layout Error"
  static let coderInit = "init(coder:) has not been implemented"
  static let unwrap = "Can't be unwrapped"
  static let retainCycle = "Retain Cycle Error : There is a possibility of memory leaks."
  static let json = "Json Parsing Error"
  static let callback = " Callback did not capture the context. "
  static let userDefaults = "Invalid UserDefaults Data Error"
}
