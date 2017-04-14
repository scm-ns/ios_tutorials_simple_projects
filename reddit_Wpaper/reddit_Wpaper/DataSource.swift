//
//  DataSource.swift
//  reddit_Wpaper
//
//  Created by scm197 on 9/7/16.
//  Copyright © 2016 scm197. All rights reserved.
//

import UIKit

class DataSource : NSObject , UICollectionViewDataSource
{
    var dataArray : NSArray?  // Array of Dicts
    var cachedImages = [String : UIImage]() // store loaded images
    let redditUrl : String!
    
    init(string : String)
    {
        redditUrl = string
    }
    
    // load data asyn
    func loadData(callback : () -> Void)
    {
        
       // get the data . show it in a collection view
        let redditNSURL : NSURL = NSURL.init(string: redditUrl)!
        let session  = NSURLSession.sharedSession()
       
        let loadTask = session.dataTaskWithURL(redditNSURL) { (let data, let response , let error) in
            
            var parsedJson : NSDictionary!
            do
            {
               parsedJson = try NSJSONSerialization.JSONObjectWithData(data!, options: 	NSJSONReadingOptions()) as? NSDictionary
               // print(parsedJson["data"]!)
                 self.dataArray = parsedJson["data"]!["children"]! as? NSArray;
                dispatch_async(dispatch_get_main_queue())
                {
                    callback();
                }
            }
            catch
            {
             //  print(error) 
                // if error happens then we just show the spinner and do nothing 
                
            }
           
        }
       
        // fectch data and fill the arrary
        loadTask.resume()
        
    }
 
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1 ; // display all the images in a single section
    }
   
   
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if let ds = dataArray
        {
             return ds.count ;
        }
        else // default value is the arary has not been filled
        {
            return 0 ;
        }
    }
   
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell : redditCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! redditCell
      
        // load the cell with the data of the request
        
        let data : NSDictionary! = self.dataArray![indexPath.row]["data"]! as! NSDictionary
        cell.title.text = data["title"] as? String
     
        let imageArray : NSArray! = data["preview"]!["images"] as! NSArray
        let imageSource : NSDictionary! = imageArray[0]["source"] as! NSDictionary
        let imageUrlString : String! = imageSource["url"]! as! String
        
        if let cellImage = cachedImages[imageUrlString] // if image already cached
        {
            cell.imageView.image = cellImage ;
        }
        else
        {
           let task = NSURLSession.sharedSession().dataTaskWithURL( NSURL.init(string: imageUrlString)!, completionHandler:{
                (imageData, response, error) in
                
                    if let imageData = imageData
                    {
                        let responseImage = UIImage(data: imageData)
                        
                        self.cachedImages[imageUrlString] = responseImage
                        dispatch_async(dispatch_get_main_queue())
                        {
                                cell.imageView.contentMode = .ScaleAspectFill
                                cell.activityIndicator.stopAnimating()
                                cell.imageView.image = responseImage
                        }
                    }
           })
            task.resume()
        }
        
        return cell ;
    }
}