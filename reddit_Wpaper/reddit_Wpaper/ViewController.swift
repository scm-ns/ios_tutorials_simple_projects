//
//  ViewController.swift
//  reddit_Wpaper
//
//  Created by scm197 on 9/6/16.
//  Copyright © 2016 scm197. All rights reserved.
//

import UIKit

let cellIdentifier : String = "redditCellID"
let redditUrl = "https://www.reddit.com/r/wallpaper/.json"

class ViewController: UICollectionViewController  , UICollectionViewDelegateFlowLayout{
    var dataSource : DataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //    Set reddit image on the navigation bar
        let redditImage : UIImageView = UIImageView(frame: CGRectMake(0, 0, 50, 50))
        redditImage.contentMode = .ScaleAspectFit
        redditImage.image = UIImage(named: "reddit")
        self.navigationItem.titleView = redditImage
     
    
        // set navigation bar button item color to reddit red
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255, green: 69, blue: 0, alpha: 1)
        
        // set background to reddit light blue
        self.collectionView?.backgroundColor = UIColor(red: 206, green: 227, blue: 248, alpha: 1)
       
        // add acitivty indication
        let activityView : UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .Gray)
        activityView.center = self.view.center
        activityView.startAnimating()
        self.view.addSubview(activityView)
     
        // Register the cell with the collection view
        self.collectionView?.registerNib( UINib.init(nibName: "redditCell", bundle: nil) , forCellWithReuseIdentifier: cellIdentifier)
   
        // set Data Source of CollectionView
        self.dataSource = DataSource(string: redditUrl)
        self.collectionView?.dataSource = self.dataSource
        
        self.dataSource?.loadData
        {
                    activityView.stopAnimating()
                self.collectionView?.reloadData()
             
        }
        
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
   
        let numRows : CGFloat = 4.0;
        let numCols : CGFloat = 2.3 ;
        
        return CGSizeMake(self.view.bounds.width / numCols, self.view.bounds.height / numRows)
        
    }
   
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}

