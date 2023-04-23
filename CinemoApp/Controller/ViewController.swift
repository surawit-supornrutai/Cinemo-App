//
//  ViewController.swift
//  CinemoApp
//
//  Created by jung on 21/4/2566 BE.
//

import UIKit
import Alamofire
import AlamofireImage
import Foundation


class ViewController: ViewControllerLayout {
    
    var listMovies: [ListMovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewLayout()
        setupDelegate()
        
        headerView.favoriteButton.addTarget(self, action: #selector(goFavoriteVC), for: .touchUpInside)
        getCurrentWeather()
    }
    
    func setupDelegate(){
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(ListMovieTableViewCell.self, forCellReuseIdentifier: ListMovieTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func goFavoriteVC() {
        let vc = FavoriteMovieViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}

extension ViewController {
    func getCurrentWeather() {
        
        let url = "\(Connection.API)"
        
        AF.request(url).validate().responseDecodable(of: GetMovieModel.self) { (response) in
            switch response.result {
            case.success(let result):
                for i in 0...result.movies.count - 1 {
                    self.listMovies.append(ListMovieModel(img: result.movies[i].posterURL,
                                                type: result.movies[i].genre,
                                                title: result.movies[i].titleEn,
                                                date: result.movies[i].dateUpdate,
                                                     detail: result.movies[i].synopsisEn))
                }
                self.tableView.reloadData()
            case .failure(_):
                self.showDialog("ไม่พบข้อมูล")
            }
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListMovieTableViewCell.identifier, for: indexPath) as! ListMovieTableViewCell
        
        if let url = URL(string: self.listMovies[indexPath.row].img) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    // Create UIImage from data and update UI on the main thread
                    DispatchQueue.main.async {
                        cell.posterImageView.image = UIImage(data: data)
                        // Do something with the image
                    }
                }
            }
            task.resume()
        }
        
        cell.typeMovieLabel.text = listMovies[indexPath.row].type
        cell.titleMovieLabel.text = listMovies[indexPath.row].title
        cell.dateLabel.text = listMovies[indexPath.row].date
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailMovieViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.selectMovie.append(listMovies[indexPath.row])
        self.present(vc, animated: true)
    }
    
}
