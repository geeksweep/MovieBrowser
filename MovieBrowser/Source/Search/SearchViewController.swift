//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, MovieSourceDelegate {
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    private let movieDataSource = MoviesDataSource()
    private let movieViewModel = MovieViewModel()
    private var searchString = ""
    private var currentMovieSelected: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
        searchButton.isEnabled = false
        configureTableView()
        
    }
    
    private func configureTableView() {
        self.movieTableView!.dataSource = self.movieDataSource
        self.movieTableView!.delegate = self.movieDataSource
        self.movieDataSource.movieDelegate = self
        
        let movieNib = UINib(nibName: "MovieCell", bundle:nil)
        self.movieTableView!.register(movieNib, forCellReuseIdentifier: "MovieCell")
    }
    
    @IBAction func searchMovies(_ sender: UIButton) {
        movieViewModel.getMoviesFrom(userSearch: searchString) { [weak self] (movies) in
            
            guard let self = self else { return }
            
            if let updatedMovies = movies{
                self.movieDataSource.movies = updatedMovies
                self.refreshMovieData()
            }
        }
    }
    
    private func refreshMovieData() {
        DispatchQueue.main.async {
            self.movieTableView.reloadData()
            //if user has scrolled down from previous search, scroll to top of tableview
            self.movieTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationViewController = segue.destination as? MovieDetailViewController{
            
            if let movieSelected = currentMovieSelected {
                destinationViewController.movieTitle = currentMovieSelected?.originalTitle
                destinationViewController.movieDate = currentMovieSelected?.shortFormatReleaseDate
                destinationViewController.movieOverView = movieSelected.overview
                destinationViewController.moviePosterImage = movieSelected.posterImage
            }
        }
    }
    
    //Search Bar Delegate Methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchButton.isEnabled = !searchText.isEmpty
        searchString = searchText
    }
    
    //Movie Source Delegate Methods
    
    func didSelect(movie: Movie) {
        currentMovieSelected = movie
        performSegue(withIdentifier: "movieDetail", sender: nil)
    }
    
}
