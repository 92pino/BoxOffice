//
//  MovieListTableCell.swift
//  BoxOffice
//
//  Created by JinBae Jeong on 2020/09/02.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MovieListTableCell"

class MovieListTableCell: UITableViewCell {
  
  let cache: NSCache = NSCache<NSString, UIImage>()
  
  var movieList: MovieList! {
    didSet {
      // 이미지 파싱... 왜 안되는걸까...
      // ==> url이 http로 시
      
      /*
        해결 방법은 info.plist에 추가 해 주면 된다.

        1. NSAppTransportSecurity [Dictionary] 추가
        2. NSAllowsArbitraryLoads [Boolean] -> YES 설정

        또는 http 대신 https 로 호출 하면 에러 발생 하지 않는다.

      */
      DispatchQueue.global().async {
        guard let imageURL: URL = URL(string: self.movieList.thumb) else {
          return
        }
        print(imageURL)
        if let image = self.cache.object(forKey: imageURL.absoluteString as NSString) {
          print("cache")
          print(image)
          DispatchQueue.main.async {
            self.moviePosterImageView.image = image
          }
        }else {
          print("not cache")
          do {
            let imageData: Data = try Data(contentsOf: imageURL)
            self.cache.setObject(UIImage(data: imageData) ?? #imageLiteral(resourceName: "img_placeholder"), forKey: imageURL.absoluteString as NSString)
            DispatchQueue.main.async {
              self.moviePosterImageView.image = UIImage(data: imageData)
            }
          } catch (let error) {
            print(error.localizedDescription)
          }
        }
      }
      
      movieTitle.text = movieList.title
      movieGradeImage(grade: movieList.grade)
      movieInfo.text = movieList.movieInfo
      movieOpenDayLabel.text = "개봉일 : \(movieList.date)"
    }
  }
  
  // MARK: - Properties
  
  private lazy var moviePosterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    return imageView
  }()
  
  private let movieTitle: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    
    return label
  }()
  
  private let movieInfo: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13)
    
    return label
  }()
  
  private let movieOpenDayLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13)
    
    return label
  }()
  
  private let gradeImageView: UIImageView = {
    let imageView = UIImageView()
    
    return imageView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = .white
    
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helpers
  func configureUI() {
    [moviePosterImageView].forEach { addSubview($0) }
    
    let titleStack = UIStackView(arrangedSubviews: [movieTitle, gradeImageView])
    titleStack.axis = .horizontal
    titleStack.spacing = 8
    titleStack.alignment = .fill
    
    let stack = UIStackView(arrangedSubviews: [titleStack, movieInfo, movieOpenDayLabel])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.spacing = 8
    stack.alignment = .leading
    stack.distribution = .fill
    
    addSubview(stack)
    
    NSLayoutConstraint.activate([
      moviePosterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
      moviePosterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
      moviePosterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      moviePosterImageView.widthAnchor.constraint(equalToConstant: 60),
      stack.leadingAnchor.constraint(equalTo: moviePosterImageView.trailingAnchor, constant: 8),
      stack.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
  }
  
  func movieGradeImage(grade: Int) {
    switch grade {
    case 0:
      self.gradeImageView.image = UIImage(named: "ic_allages")
    case 12:
      self.gradeImageView.image = UIImage(named: "ic_12")
    case 15:
      self.gradeImageView.image = UIImage(named: "ic_15")
    case 19:
      self.gradeImageView.image = UIImage(named: "ic_19")
    default:
      self.gradeImageView.image = UIImage(named: "ic_allages")
    }
  }
  
}
