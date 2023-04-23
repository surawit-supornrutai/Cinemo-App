//
//  DetailMovieViewController.swift
//  CinemoApp
//
//  Created by jung on 21/4/2566 BE.
//

import UIKit


class DetailMovieViewController: DetailMovieLayout {
    
    var selectMovie:[ListMovieModel] = []
    var checkFav = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewLayout()
        setupDetail()
        changeButton()
        
        headerView.headButton.addTarget(self, action: #selector(goBackVC), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
    }
    
    @objc func goBackVC() {
        self.dismiss(animated: true)
    }
    
    @objc func addToFavorite() {
        if !checkFav {
            GetFavoriteMovieModel.addFavoriteMovie(selectMovie[0])
            changeButton()
        } else {
            if let index = GetFavoriteMovieModel.indexOfMovie(title: self.selectMovie[0].title) {
                removeFavorite(index: index)
                changeButton()
            } else {
                print("xxx can't remove")
            }
        }
        
    }
    
    func removeFavorite(index: Int) {
        if GetFavoriteMovieModel.removeIndex(index: index) {
            print("xxx update when remove \(GetFavoriteMovieModel.movies)")
            checkFav = false
        } else {
            print("xxx can't remove")
        }
    }
    
    func changeButton(){
        
        if (GetFavoriteMovieModel.indexOfMovie(title: self.selectMovie[0].title) != nil) {
            addButton.setTitle("Remove from Favorite", for: .normal)
            addButton.setTitleColor(.black, for: .normal)
            addButton.layer.backgroundColor = UIColor.green.cgColor
            checkFav = true
        } else {
            addButton.setTitle("Add to Favorite", for: .normal)
            addButton.setTitleColor(.white, for: .normal)
            addButton.layer.backgroundColor = UIColor.systemPink.cgColor
            checkFav = false
        }
        
    }
    
    func setupDetail(){
        
        if let url = URL(string: self.selectMovie[0].img) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    // Create UIImage from data and update UI on the main thread
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                        // Do something with the image
                    }
                }
            }
            task.resume()
        }
        
        typeLabel.text = self.selectMovie[0].type
        titleLabel.text = self.selectMovie[0].title
        detailLabel.text = self.selectMovie[0].detail
    }
}
