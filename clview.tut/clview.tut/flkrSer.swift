//
//  flkrSer.swift
//  clview.tut
//
//  Created by scm197 on 10/24/16.
//  Copyright © 2016 scm197. All rights reserved.
//

import UIKit

let apiKey = "123"



struct FlkSearchRes {
    let searchTerm : String
    let searchTermRes : [FlkPhoto]
}



class flkrSer{
    
    let dataFetchQ =  NSOperationQueue()
  
    func searchFlkForTerm(searchTerm : String , completion : (results : FlkSearchRes? , error: NSError?) -> Void)
    {
        
        guard let searchURL = flkUrlForSearchTerm(searchTerm) else
        {
            let APIError = NSError(domain: "Flikr Search", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unable to form search url"])
            completion(results: nil, error: APIError)
            return
        }
        
        
        let searchRequest = NSURLRequest(URL: searchURL)
      
        
       
        NSURLSession.sharedSession().dataTaskWithRequest(searchRequest  , completionHandler:
        { (data, response, error) in
            if let _ = error
            {
                let APIError = NSError(domain: "FlikrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey : "Api request errored out"])
                NSOperationQueue.mainQueue().addOperationWithBlock({ 
                    completion(results: nil, error: APIError)
                })
                return
            }
           
           
            guard let _ = response as! NSHTTPURLResponse? ,let data = data else
            {
                 let APIError = NSError(domain: "FlikrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey : "Api request errored out"])
                NSOperationQueue.mainQueue().addOperationWithBlock({ 
                    completion(results: nil, error: APIError)
                })
                return
            }
            
            do
            {
                guard let resultsDict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.init(rawValue: 0)) as? [String :AnyObject] ,
                      let stat = resultsDict["stat"] as? String
                else // get both the serialized data and extract the stat from the data
                {
                    let APIError = NSError(domain: "FlikrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey : "Api request errored out"])
                    NSOperationQueue.mainQueue().addOperationWithBlock({
                        completion(results: nil, error: APIError)
                    })
                    return  
                }
                
                switch(stat)
                {
                   case "ok":
                    print("Results processed ok")
                   case "fail": // on failure see if the dict contains the message if so show if else , show a different message
                    
                    if let msg = resultsDict["message"]
                    {
                         let APIError = NSError(domain: "FlikrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey : msg])
                        NSOperationQueue.mainQueue().addOperationWithBlock({
                            completion(results: nil, error: APIError)
                        })
                        return
                    }
                    else
                    {
                        let APIError = NSError(domain: "FlikrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey : "Api request errored out"])
                        NSOperationQueue.mainQueue().addOperationWithBlock({
                            completion(results: nil, error: APIError)
                        })
                         return
                    }
                    default:
                        let APIError = NSError(domain: "FlikrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey : "Api request errored out"])
                        NSOperationQueue.mainQueue().addOperationWithBlock({
                            completion(results: nil, error: APIError)
                        })
                         return
                }
               
                guard let photosContainer = resultsDict["photos"] as? [String:AnyObject] ,
                      let photosReceived = photosContainer["photo"] as? [[String:AnyObject]]
                else
                {
                         let APIError = NSError(domain: "FlikrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey : "Api request errored out"])
                        NSOperationQueue.mainQueue().addOperationWithBlock({
                            completion(results: nil, error: APIError)
                        })
                         return
                }
                
               
                
                
                var flkPhotos = [FlkPhoto]()
               
                for photoObj in photosReceived
                {
                    
                    guard let photoID = photoObj["id"] as? String ,
                          let farm = photoObj["farm"] as? Int ,
                          let server = photoObj["server"] as? String ,
                          let secret = photoObj["secret"] as? String
                    else
                    {
                            break
                    }
                    
                    let flkPhoto = FlkPhoto(photoID: photoID, farm: farm, server: server, secret: secret)
                   
                    guard let url = flkPhoto.flikrImageUrl() ,
                          let imageData =  NSData(contentsOfURL: url as NSURL)
                    else
                    {
                       break
                    }
                    
                    if let image = UIImage(data: imageData)
                    {
                        flkPhoto.thumbNail = image
                        flkPhotos.append(flkPhoto)
                    }
                    
                }
                
                 NSOperationQueue.mainQueue().addOperationWithBlock({
                    completion(results: FlkSearchRes(searchTerm: searchTerm ,searchTermRes:  flkPhotos), error: nil)
                })
                
                
            }
            catch _
            {
                    completion(results: nil , error: nil)
                    return
            }
            
            
        }).resume()
    }
    
    
    private func flkUrlForSearchTerm(searchTerm : String) -> NSURL?
    {
        guard let escapedTerm = searchTerm.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet()) else
        {
            return nil
        }

        let URLString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(escapedTerm)&per_page=20&format=json&nojsoncallback=1"
        
        guard let url = NSURL(string: URLString) else
        {
           return nil
        }
        
       return url
    }
}
