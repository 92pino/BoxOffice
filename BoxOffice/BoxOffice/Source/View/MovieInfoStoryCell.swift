//
//  MovieInfoStoryCell.swift
//  BoxOffice
//
//  Created by JinBae Jeong on 2020/09/05.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit

class MovieInfoStoryCell: UITableViewCell {
  
  let movieStoryTextView: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    [movieStoryTextView].forEach { addSubview($0) }
    NSLayoutConstraint.activate([
      movieStoryTextView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
      movieStoryTextView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
      movieStoryTextView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
      
    ])
  }
  
}
