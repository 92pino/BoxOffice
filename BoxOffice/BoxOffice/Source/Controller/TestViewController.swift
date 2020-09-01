//
//  TestViewController.swift
//  BoxOffice
//
//  Created by JinBae Jeong on 2020/09/02.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    test()
  }
  
  private func test() {
    DataManager.shared.service.fetchBoxOfficeData(requestType: RequestType.movieList, paramTitle: "order_type", param: "1") { result in
      print(result)
    }
  }
  
}
