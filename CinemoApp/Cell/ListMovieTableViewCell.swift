//
//  ListMovieTableViewCell.swift
//  CinemoApp
//
//  Created by jung on 21/4/2566 BE.
//

import UIKit

class ListMovieTableViewCell: UITableViewCell {

    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let borderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = UIScreen.main.bounds.width * 0.04
        view.backgroundColor = UIColor(hex: "F8F9F9")
        return view
    }()
    
    let posterImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = UIScreen.main.bounds.width * 0.04
        image.layer.masksToBounds = true
        return image
    }()
    
    let typeMovieLabel: UILabel = {
        let label = UILabel()
        label.text = "Horror/Thriller"
        label.numberOfLines = 2
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    let titleMovieLabel: UILabel = {
        let label = UILabel()
        label.text = "A Quite Place Part ||"
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "October 1, 2021"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    let viewmoreLabel: UILabel = {
        let label = UILabel()
        label.text = "View more"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    let viewmoreIC: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .lightGray
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        //background
        self.addSubview(borderView)
        self.addConstraints(with: "V:[v0(\(screenWidth * 0.5))]", to: borderView)
        self.addConstraints(with: "H:[v0(\(screenWidth * 0.9))]", to: borderView)
        borderView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        borderView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        borderView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        borderView.addSubviews([posterImageView, typeMovieLabel, titleMovieLabel, dateLabel, viewmoreLabel, viewmoreIC])
        //image
        self.addConstraints(with: "V:|-10-[v0]-10-|", to: posterImageView)
        self.addConstraints(with: "H:|-10-[v0(\(screenWidth * 0.35))]", to: posterImageView)
        
        //type
        self.addConstraints(with: "V:[v0]", to: typeMovieLabel)
        self.addConstraints(with: "H:[v0]-20-|", to: typeMovieLabel)
        typeMovieLabel.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 15).isActive = true
        typeMovieLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 20).isActive = true
        
        //nameMovie
        self.addConstraints(with: "V:[v0]", to: titleMovieLabel)
        self.addConstraints(with: "H:[v0]-20-|", to: titleMovieLabel)
        titleMovieLabel.topAnchor.constraint(equalTo: typeMovieLabel.bottomAnchor, constant: 5).isActive = true
        titleMovieLabel.leftAnchor.constraint(equalTo: typeMovieLabel.leftAnchor).isActive = true
        
        //date
        self.addConstraints(with: "V:[v0]", to: dateLabel)
        self.addConstraints(with: "H:[v0]", to: dateLabel)
        dateLabel.topAnchor.constraint(equalTo: titleMovieLabel.bottomAnchor, constant: 15).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: typeMovieLabel.leftAnchor).isActive = true
        
        //viewmore
        self.addConstraints(with: "V:[v0]", to: viewmoreLabel)
        self.addConstraints(with: "H:[v0]", to: viewmoreLabel)
        viewmoreLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        viewmoreLabel.leftAnchor.constraint(equalTo: typeMovieLabel.leftAnchor).isActive = true
        
        //viewIC
        self.addConstraints(with: "V:[v0(20)]", to: viewmoreIC)
        self.addConstraints(with: "H:[v0(20)]", to: viewmoreIC)
        viewmoreIC.centerYAnchor.constraint(equalTo: viewmoreLabel.centerYAnchor).isActive = true
        viewmoreIC.leftAnchor.constraint(equalTo: viewmoreLabel.rightAnchor, constant: 5).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
