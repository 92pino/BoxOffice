//
//  MovieDetailHeaderCell.swift
//  BoxOffice
//
//  Created by JinBae Jeong on 2020/09/05.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit

class MovieDetailHeaderCell: UITableViewCell {
  
  var moviePosterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = #imageLiteral(resourceName: "img_placeholder")
    
    return imageView
  }()
  
  var movieTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "title"
    
    return label
  }()
  
  var movieOpenDayLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "openDay"
    
    return label
  }()
  
  var movieGenreLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "genre"
    
    return label
  }()
  
  var gradeImageView: UIImageView = {
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
  
  private func configureUI() {
    [moviePosterImageView].forEach { addSubview($0) }
    
    // 상단 타이틀 stack
    let titleStack = UIStackView(arrangedSubviews: [movieTitleLabel, gradeImageView])
    titleStack.axis = .horizontal
    titleStack.spacing = 8
    titleStack.alignment = .fill
    
    let topStack = UIStackView(arrangedSubviews: [titleStack, movieOpenDayLabel, movieGenreLabel])
    topStack.translatesAutoresizingMaskIntoConstraints = false
    topStack.axis = .vertical
    topStack.spacing = 8
    topStack.alignment = .leading
    topStack.distribution = .fill
    
    addSubview(topStack)
    
    NSLayoutConstraint.activate([
      moviePosterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
      moviePosterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
      moviePosterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
      moviePosterImageView.widthAnchor.constraint(equalToConstant: self.frame.width / 3),
      
      topStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
      topStack.leadingAnchor.constraint(equalTo: moviePosterImageView.trailingAnchor, constant: 15),
      topStack.centerYAnchor.constraint(equalTo: moviePosterImageView.centerYAnchor),
    ])
  }
  
}
