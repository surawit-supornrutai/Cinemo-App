//
//  HeaderView.swift
//  CinemoApp
//
//  Created by jung on 21/4/2566 BE.
//

import UIKit

class HeaderView: UIView {
    
    let mainLayout: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let headButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Cinemo", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        return btn
    }()
    
    let favoriteButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        btn.tintColor = .systemPink
        btn.backgroundColor = .clear
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        self.addSubview(mainLayout)
        self.addConstraints(with: "V:|[v0]|", to: mainLayout)
        self.addConstraints(with: "H:|[v0]|",to: mainLayout)
        
        mainLayout.addSubview(headButton)
        mainLayout.addConstraints(with: "V:|[v0]|", to: headButton)
        mainLayout.addConstraints(with: "H:|-20-[v0]",to: headButton)
        
        mainLayout.addSubview(favoriteButton)
        mainLayout.addConstraints(with: "V:[v0(40)]", to: favoriteButton)
        mainLayout.addConstraints(with: "H:[v0(40)]-20-|",to: favoriteButton)
        favoriteButton.centerYAnchor.constraint(equalTo: mainLayout.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
