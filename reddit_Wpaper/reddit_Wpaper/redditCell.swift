//
//  redditCell.swift
//  reddit_Wpaper
//
//  Created by scm197 on 9/7/16.
//  Copyright © 2016 scm197. All rights reserved.
//

import UIKit

class redditCell: UICollectionViewCell {

 
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!

 
    let activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .White)
   
    func startLoading()
    {
        activityIndicator.center = imageView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        imageView.addSubview(activityIndicator)
        
    }
  
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
