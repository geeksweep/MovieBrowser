//
//  MovieViewModel.swift
//  MovieBrowser
//
//  Created by CWS on 6/14/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieViewModel: NSObject {

    override init() {
        super.init()
    }
    
    // retrieve movies based on api key + query string text from user
    func getMoviesFrom(userSearch:String, completion:@escaping ([Movie]?) -> Void) {
        var urlComponents = URLComponents(string: Network.movieUrlSearchConstant)
        let queryItems = [URLQueryItem(name: "api_key", value: Network.apiKey), URLQueryItem(name: "query", value: userSearch)]
        urlComponents?.queryItems = queryItems
        
        guard let movieURLRequest = URL(string: urlComponents?.string ?? "") else { return }
        
        var request = URLRequest(url: movieURLRequest)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        BaseAPI.getData(type: Root.self, req: request) { movies in
            if let results = movies?.results{
                self.convertMovieData(results: results)
                completion(results)
            } else {
                //send error message in the future as an alert or ?
            }
        }
    }
    
    private func convertMovieData(results:[Movie]){
        for i in results {
            
            ///Dates
            
            //original date format
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateFromString = dateFormatter.date(from: i.releaseDate)
            
            //short date format
            dateFormatter.dateFormat = "M/dd/YYYY"
            let someShortDateString = (dateFromString != nil) ? dateFormatter.string(from: dateFromString!) : "Unavailable"
            i.shortFormatReleaseDate = "Release Date: \(someShortDateString)"
            
            //long date format
            dateFormatter.dateFormat = "MMMM dd, YYYY"
            let someLongDateString = (dateFromString != nil) ? dateFormatter.string(from: dateFromString!) : "Unavailable Release Date"
            i.longFormatReleaseDate = someLongDateString
            
            
            ///Movie Overview/Description
            if i.overview.isEmpty {
                i.overview = "No Available Description"
            }
            
            /// Poster Image
            // Create URL
            if let imagePath = i.posterPath {
                if let url = URL(string: Network.movieUrlPosterPathConstant + imagePath){
                
                // Get Image Data
                    if let data = try? Data(contentsOf: url) {
                        i.posterImage = data
                    }
                }
            }

        }
    }
}
