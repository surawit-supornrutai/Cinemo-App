//
//  FavoriteMovieViewController.swift
//  CinemoApp
//
//  Created by jung on 21/4/2566 BE.
//

import UIKit

class FavoriteMovieViewController: FavoriteMovieLayout {

    var listMovies: [ListMovieModel] = GetFavoriteMovieModel.movies
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewLayout()
        setupDelegate()
        
        headerView.headButton.addTarget(self, action: #selector(goBackVC), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listMovies = GetFavoriteMovieModel.movies
        tableView.reloadData()
    }
    
    @objc func goBackVC() {
        self.dismiss(animated: true)
    }
    
    func setupDelegate(){
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(ListMovieTableViewCell.self, forCellReuseIdentifier: ListMovieTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
}

extension FavoriteMovieViewController: UITableViewDelegate, UITableViewDataSource {
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
