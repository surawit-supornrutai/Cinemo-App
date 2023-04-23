//
//  DetailMovieLayout.swift
//  CinemoApp
//
//  Created by jung on 21/4/2566 BE.
//

import UIKit

class DetailMovieLayout: UIViewController {

    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    let headerView: HeaderView = {
        let view = HeaderView()
        view.favoriteButton.isHidden = true
        return view
    }()
    
    let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = UIScreen.main.bounds.width * 0.04
        image.layer.masksToBounds = true
        return image
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    let detailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    let addButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add to Favorite", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.backgroundColor = UIColor.systemPink.cgColor
        btn.layer.cornerRadius = UIScreen.main.bounds.width * 0.04
        btn.layer.masksToBounds = true
        return btn
    }()
    
    func setUpViewLayout(){
        view.backgroundColor = .white
        
        //header
        view.addSubview(headerView)
        view.addConstraints(with: "V:|-top-[v0(\(screenWidth/8))]", to: headerView, topPadding: 50)
        view.addConstraints(with: "H:|[v0]|",to: headerView)
        
        //scrollview
        view.addSubview(mainScrollView)
        view.addConstraints(with: "V:[v0]-80-|", to: mainScrollView)
        view.addConstraints(with: "H:|[v0]|", to: mainScrollView)
        mainScrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10).isActive = true
        
        
        //image
        mainScrollView.addSubview(imageView)
        mainScrollView.addConstraints(with: "V:[v0(\(screenHeight * 0.45))]", to: imageView)
        mainScrollView.addConstraints(with: "H:[v0(\(screenWidth * 0.7))]",to: imageView)
        imageView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10).isActive = true
        
        //type
        mainScrollView.addSubview(typeLabel)
        mainScrollView.addConstraints(with: "V:[v0]", to: typeLabel)
        mainScrollView.addConstraints(with: "H:[v0]",to: typeLabel)
        typeLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        typeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        
        //title
        mainScrollView.addSubview(titleLabel)
        mainScrollView.addConstraints(with: "V:[v0]", to: titleLabel)
        mainScrollView.addConstraints(with: "H:[v0]",to: titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10).isActive = true
        
//        //detail
        mainScrollView.addSubview(detailLabel)
        mainScrollView.addConstraints(with: "V:[v0]", to: detailLabel)
        mainScrollView.addConstraints(with: "H:|-20-[v0]-20-|",to: detailLabel)
        detailLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        
        //button
        view.addSubview(addButton)
        view.addConstraints(with: "V:[v0(\(screenHeight * 0.05))]", to: addButton)
        view.addConstraints(with: "H:[v0(\(screenWidth * 0.5))]",to: addButton)
        addButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
    }

}
