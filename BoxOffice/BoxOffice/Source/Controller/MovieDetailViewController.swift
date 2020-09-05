//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by JinBae Jeong on 2020/09/05.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit

class MovieDetailViewController: UITableViewController {
  
  // Mark: - Properties
  
  private let cache: NSCache = NSCache<NSString, UIImage>()
  var movieId: String?
  var movietitle: String?
  
  // TODO: 헤더 영역이 안잡히고있다.....ㅠㅠ
  // Section0으로 바꿔야되나
  var headerView: MovieDetailHeaderView = {
    let headerView = MovieDetailHeaderView()
    headerView.setNeedsLayout()
    headerView.layoutIfNeeded()
    
    return headerView
  }()
  
  var movieDetail: BoxOfficeDetail? {
    didSet {
      DispatchQueue.main.async { [weak self] in
        self?.setupTableViewHeader()
        self?.tableView.reloadData()
      }
    }
  }
  
  // Mark: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    networkService()
    view.backgroundColor = .white
    navigationItem.title = movietitle
    
    setupTableview()
    
    tableView.tableHeaderView = headerView
    
    setupTableViewHeader()
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 4
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    case 1:
      return 1
    case 2:
      return 1
    case 3:
      return 1
    default:
      return 0
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //    if indexPath.section == 0 {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieInfoStory", for: indexPath) as? MovieInfoStoryCell else {
      return UITableViewCell()
    }
    cell.movieStoryTextView.text = movieDetail?.synopsis
    return cell
    //    }
  }
  
  // MARK: - Helpers
  private func networkService() {
    DataManager.shared.service.fetchBoxOfficeData(requestType: RequestType.movieDetail, paramTitle: "id", param: movieId!) { (result: Result<BoxOfficeDetail, ServiceError>) in
      print("@@@@ :", result)
      DispatchQueue.main.async {
        switch result {
        case .success(let contents):
          self.movieDetail = contents
        case .failure(let error):
          logger(error.localizedDescription)
        }
      }
    }
  }
  
  private func setupTableview() {
    tableView.register(MovieInfoStoryCell.self, forCellReuseIdentifier: "movieInfoStory")
  }
  
  private func setupTableViewHeader() {
    setupMoviePosterImage()
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      headerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
    
    guard let movieDetail = movieDetail else { return }
    
    headerView.movieTitleLabel.text = movieDetail.title
    headerView.movieGenreLabel.text = movieDetail.genreAndDuration
    headerView.movieOpenDayLabel.text = movieDetail.longOpenDay
  }
  
  func setupMoviePosterImage(){
      
      DispatchQueue.global().async { [weak self] in
          guard let self = self else {
              return
          }
          
          guard let movieDetail = self.movieDetail else {
              return
          }
    
          guard let imageURL: URL = URL(string: movieDetail.image ) else {
              return
          }
          
          // caching image
          if let image = self.cache.object(forKey: imageURL.absoluteString as NSString) {
              DispatchQueue.main.async {
                  self.headerView.moviePosterImageView.image = image
              }
          }else {
              do {
                  let imageData: Data = try Data(contentsOf: imageURL)
                  self.cache.setObject(UIImage(data: imageData) ?? #imageLiteral(resourceName: "img_placeholder"), forKey: imageURL.absoluteString as NSString)
                  DispatchQueue.main.async {
                      self.headerView.moviePosterImageView.image = UIImage(data: imageData)
                  }
              } catch (let error) {
                  print(error.localizedDescription)
              }
          }
      }
  }
  
  
  // Mark: - Selectors
  
  
}
