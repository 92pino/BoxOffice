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
  
  var param: String = "0" {
    didSet {
      DataManager.shared.service.fetchBoxOfficeData(requestType: RequestType.movieList, paramTitle: "order_type", param: param) { (result: Result<BoxOfficeList, ServiceError>) in
        DispatchQueue.main.async {
          switch result {
          case .success(let contents):
            self.movieList = contents.movies
            self.activityIndicatorView.stopAnimating()
            self.table.reloadData()
          case .failure(let error):
            logger(error.localizedDescription)
          }
        }
      }
    }
  }
  
  private var movieList: [MovieList] = []
  
  // Mark: - Properties
  
  private var tableviewRefreshControl = UIRefreshControl()
  private let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
  
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
    
    request()
    
    if #available(iOS 10.0, *) {
      table.refreshControl = self.tableviewRefreshControl
    } else{
      table.addSubview(tableviewRefreshControl)
    }
    
    self.tableviewRefreshControl.addTarget(self, action: #selector(refreshMovieData), for: .valueChanged)
    
    self.view.addSubview(activityIndicatorView)
    activityIndicatorView.color = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    activityIndicatorView.frame = self.view.frame
    activityIndicatorView.center = self.view.center
    activityIndicatorView.startAnimating()
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
    DataManager.shared.service.fetchBoxOfficeData(requestType: RequestType.movieList, paramTitle: "order_type", param: param) { (result: Result<BoxOfficeList, ServiceError>) in
      DispatchQueue.main.async {
        switch result {
        case .success(let contents):
          self.movieList = contents.movies
          self.table.reloadData()
        case .failure(let error):
          logger(error.localizedDescription)
        }
      }
    }
  }
  
  private func request(usingIndicator: Bool = true) {
    DataManager.shared.service.fetchBoxOfficeData(requestType: RequestType.movieList, paramTitle: "order_type", param: param) { (result: Result<BoxOfficeList, ServiceError>) in
      DispatchQueue.main.async {
        usingIndicator ? self.activityIndicatorView.stopAnimating() : self.tableviewRefreshControl.endRefreshing()
      }
      
      // TODO: - 새로고침 했을 경우 데이터를 받아와서 refresh
    }
  }
  
  // Mark: - Selectors
  @objc func refreshMovieData() {
    request(usingIndicator: false)
  }
  
}

// MARK: - MovieListTableViewDataSource

extension MovieListTableViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movieList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as?
      MovieListTableCell else {
        return UITableViewCell()
    }
    // 테이블셀 왼쪽 여백 없애기
    cell.separatorInset = UIEdgeInsets.zero
    cell.selectionStyle = .none
    
    cell.movieList = movieList[indexPath.row]
    
    return cell
  }
}

extension MovieListTableViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let controller = MovieDetailViewController()
    
    let detailMovie = movieList[indexPath.row]
    controller.movieId = detailMovie.id
    controller.movietitle = detailMovie.title
    
    navigationController?.pushViewController(controller, animated: true)
  }
}
