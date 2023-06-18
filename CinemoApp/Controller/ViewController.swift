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
    var filteredMovies: [ListMovieModel] = []
    
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
        searchBarView.delegate = self
    }
    
    @objc func goFavoriteVC() {
        let vc = FavoriteMovieViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}

extension ViewController {
    func getCurrentWeather() {
        self.activityIndicator.startAnimating()
        let url = "\(Connection.API)"
        
        AF.request(url).validate().responseDecodable(of: GetMovieModel.self) { (response) in
            print("xxx response \(response)")
            switch response.result {
            case.success(let result):
                print("xxx result \(result)")
                for i in 0...result.movies.count - 1 {
                    self.listMovies.append(ListMovieModel(img: result.movies[i].posterURL,
                                                type: result.movies[i].genre,
                                                title: result.movies[i].titleEn,
                                                date: result.movies[i].dateUpdate,
                                                     detail: result.movies[i].synopsisEn))
                }
                self.filteredMovies = self.listMovies
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            case .failure(_):
                self.showDialog("ไม่พบข้อมูล")
                self.activityIndicator.stopAnimating()
            }
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListMovieTableViewCell.identifier, for: indexPath) as! ListMovieTableViewCell
        
        if let url = URL(string: self.filteredMovies[indexPath.row].img) {
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
        
        cell.typeMovieLabel.text = filteredMovies[indexPath.row].type
        cell.titleMovieLabel.text = filteredMovies[indexPath.row].title
        cell.dateLabel.text = filteredMovies[indexPath.row].date
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailMovieViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.selectMovie.append(filteredMovies[indexPath.row])
        self.present(vc, animated: true)
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.activityIndicator.startAnimating()
        // Access the search query using searchBar.text
        let searchText = searchBar.text ?? ""
        
        if searchText.isEmpty {
            // Clear the filtered array
            filteredMovies = self.listMovies
        } else {
            // Perform search operation
            filteredMovies = self.listMovies.filter { movie in
                return movie.title.contains(searchText)
            }
        }
        
        searchBar.resignFirstResponder()
        tableView.reloadData()
        self.activityIndicator.stopAnimating()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.activityIndicator.startAnimating()
        // Access the search query using searchBar.text
        let searchText = searchBar.text ?? ""
        
        if searchText.isEmpty {
            // Clear the filtered array
            filteredMovies = self.listMovies
        } else {
            // Perform search operation
            filteredMovies = self.listMovies.filter { movie in
                return movie.title.contains(searchText)
            }
        }
        
        tableView.reloadData()
        self.activityIndicator.stopAnimating()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.activityIndicator.startAnimating()
        // Clear the search query and the filtered array
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filteredMovies = []
        tableView.reloadData()
        self.activityIndicator.stopAnimating()
    }


}
