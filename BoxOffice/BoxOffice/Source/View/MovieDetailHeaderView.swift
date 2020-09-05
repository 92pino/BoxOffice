//
//  MovieDetailHeaderView.swift
//  BoxOffice
//
//  Created by JinBae Jeong on 2020/09/05.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit

class MovieDetailHeaderView: UIView {
  
  var moviePosterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    return imageView
  }()
  
  var movieTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  var movieOpenDayLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  var movieGenreLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureUI()
    backgroundColor = .red
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    [moviePosterImageView].forEach { addSubview($0) }
    
    let stack = UIStackView(arrangedSubviews: [movieTitleLabel, movieOpenDayLabel, movieGenreLabel])
    stack.axis = .vertical
    stack.spacing = 8
    stack.alignment = .leading
    stack.distribution = .fill
    
    addSubview(stack)
    
    NSLayoutConstraint.activate([
      moviePosterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
      moviePosterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
      moviePosterImageView.trailingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 5),
      moviePosterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
      
      stack.topAnchor.constraint(equalTo: topAnchor),
      stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
      stack.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }
  
}
