//
//  MainTabBarController.swift
//  BoxOffice
//
//  Created by JinBae Jeong on 2020/09/02.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  // Mark: - Properties
  
  // Mark: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
  }
  
  // MARK: - Helpers
  private func configureUI() {
    view.backgroundColor = .white
    tabBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    tabBar.barTintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    
    setupViewControllers()
  }
  
  private func setupViewControllers() {
    viewControllers = [
      generateNavigationController(for: MovieListTableViewController(), title: "Table", barItemTitle: "예매율순", image: #imageLiteral(resourceName: "ic_list")),
      generateNavigationController(for: MovieListCollectionViewController(), title: "Collection", barItemTitle: "예매율순", image: #imageLiteral(resourceName: "ic_collection"))
    ]
  }
  
  private func generateNavigationController(for viewcontroller: UIViewController, title: String, barItemTitle: String, image: UIImage) -> UIViewController {
    let settingButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_settings"), style: .plain, target: self, action: #selector(sortingMovieList))
    
    navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    navigationItem.title = barItemTitle
    navigationItem.rightBarButtonItem = settingButton
    navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    viewcontroller.tabBarItem.title = title
    viewcontroller.tabBarItem.image = image
    
    return viewcontroller
  }
  
  // Mark: - Selectors
  @objc func sortingMovieList(_ sender: UIButton) {
    
  }
  
}

