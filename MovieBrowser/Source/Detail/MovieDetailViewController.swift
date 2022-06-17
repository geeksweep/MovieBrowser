//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movieTitle:String?
    var movieDate:String?
    var movieOverView:String?
    var moviePosterImage:Data?
    
    @IBOutlet weak private var detailTitleLabel: UILabel!
    @IBOutlet weak private var detailDateLabel: UILabel!
    @IBOutlet weak private var detailMovieImageView: UIImageView!
    @IBOutlet weak private var detailMovieOverViewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTitleLabel.text = movieTitle
        detailDateLabel.text = movieDate
        detailMovieOverViewTextView.text = movieOverView
        if let posterImageData = moviePosterImage {
            detailMovieImageView.image = UIImage(data: posterImageData)
        }
        
        detailMovieOverViewTextView.textContainerInset = UIEdgeInsets.zero
        detailMovieOverViewTextView.textContainer.lineFragmentPadding = 0
    }
    
}
