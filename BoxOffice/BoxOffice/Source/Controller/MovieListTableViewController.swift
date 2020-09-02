//
//  MovieListTableViewController.swift
//  BoxOffice
//
//  Created by JinBae Jeong on 2020/09/02.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MovieListTableCell"

class MovieListTableViewController: UIViewController {

  private var movieList: [MovieList] = []
  
  // Mark: - Properties
  
  private lazy var table: UITableView = {
    let tableView = UITableView(frame: .zero)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.register(MovieListTableCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.dataSource = self
    tableView.delegate = self
    
    return tableView
  }()
  
  // Mark: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    networkService()
    configureUI()
  }
  
  // MARK: - Helpers
  
  private func configureUI() {
    let guide = view.safeAreaLayoutGuide
    
    view.addSubview(table)
    NSLayoutConstraint.activate([
      table.topAnchor.constraint(equalTo: guide.topAnchor),
      table.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
      table.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
      table.bottomAnchor  .constraint(equalTo: guide.bottomAnchor),
    ])
  }
  
  private func networkService() {
    DataManager.shared.service.fetchBoxOfficeData(requestType: RequestType.movieList, paramTitle: "order_type", param: "1") { result in
      DispatchQueue.main.async {
        switch result {
        case .success(let contents):
          print("DEBUG : ", contents)
          self.movieList = contents.movies
          self.table.reloadData()
        case .failure(let error):
          logger(error.localizedDescription)
        }
      }
    }
  }
  
  // Mark: - Selectors

}

// MARK: - MovieListTableViewDataSource

extension MovieListTableViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movieList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? MovieListTableCell else {
    return UITableViewCell()
    }
    
    print("##### :", movieList[indexPath.row])
    
    cell.movieList = movieList[indexPath.row]
    
    return cell
  }
}

extension MovieListTableViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110
  }
}
