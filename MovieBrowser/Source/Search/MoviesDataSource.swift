//
//  MovieViewDataSource.swift
//  MovieBrowser
//
//  Created by Chad Saxon on 6/14/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit

protocol MovieSourceDelegate{
    func didSelect(movie:Movie)
}

class MoviesDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var movieDelegate: MovieSourceDelegate?
    var movies = [Movie]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movieCell = tableView.dequeueReusableCell(withIdentifier:"MovieCell", for: indexPath) as! MovieCell
        
        movieCell.movieTitleLabel.text = movies[indexPath.row].originalTitle
        movieCell.movieReleaseDate.text = movies[indexPath.row].longFormatReleaseDate
        movieCell.movieRating.text = String(movies[indexPath.row].voteAverage)
        
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieSelected = self.movies[indexPath.row]
        self.movieDelegate?.didSelect(movie: movieSelected)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
