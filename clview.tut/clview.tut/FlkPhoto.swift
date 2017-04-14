//
//  FlkPhoto.swift
//  clview.tut
//
//  Created by scm197 on 10/24/16.
//  Copyright © 2016 scm197. All rights reserved.
//

import UIKit


class FlkPhoto : Equatable
{
    var thumbNail : UIImage?
    var largeImage : UIImage?
    let photoID : String
    let farm : Int
    let server : String
    let secret : String
   
    init(photoID : String , farm : Int , server : String , secret : String)
    {
            self.photoID = photoID
            self.farm = farm
            self.server = server
            self.secret = secret
    }
    
    func flikrImageUrl(size : String = "m") -> NSURL?
    {
       if let url = NSURL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_\(size).jpg")
        {
            return url
        }
        return nil
    }
    
   
    // keep in mind that the completion block should only update UI . Anything intensive should be done elsewhere
    func loadLargerImage(completion:(photo:FlkPhoto , error:NSError?)->Void)
    {
        // if we failed to get the url , then execepute the completion block with the photo and return
        guard let loadURL = flikrImageUrl("b") else
        {
          dispatch_async(dispatch_get_main_queue())
          {
            completion(photo: self , error: nil)
          }
            
            return
        }
        
        
        let loadRequest = NSURLRequest(URL: loadURL)
        
        NSURLSession.sharedSession().dataTaskWithRequest(loadRequest , completionHandler:
        { (data, response , error) in
            // if error occured then end with completion block
           if let error = error
           {
                dispatch_async(dispatch_get_main_queue())
                {
                        completion(photo: self , error: error as NSError?)
                }
           }
            
            // check if data has been received
            guard let data = data else
            {
                 dispatch_async(dispatch_get_main_queue())
                {
                        completion(photo: self , error: nil)
                }
                return
            }
           
            // the data had been loaded successfully
            let returnedImage = UIImage(data: data)
            self.largeImage = returnedImage
           
            dispatch_async(dispatch_get_main_queue())
            {
               completion(photo: self , error: nil)
            }
            
        }).resume()
    }
  
    // given a width , what should the height of the image be for good aspect ratio
    // To get a clue about what aspect ratio to use ,  utilize the thumbnail image
    func sizeToFillWidthOfSize(size:CGSize) -> CGSize
    {
        guard let thumbnail = thumbNail else // if there is no thumbnail image , then we cannot get the aspect ratio and hence no image height
        {
           return size
        }
        
        let imageSize = thumbnail.size
        var returnSize = size ;
        
        let aspectRatio = (imageSize.width) / (imageSize.height)
      
        // scale the height to the aspect ratio
        returnSize.height = returnSize.width / aspectRatio
       
       
        // if the scaled height is larger than the height of the required cell 
        // we fix the height to the max and scale down the width
        if returnSize.height > size.height
        {
           returnSize.height = size.height
           returnSize.width = size.height * aspectRatio
        }
        return returnSize
    }
   
}

func ==(lhs:FlkPhoto, rhs:FlkPhoto)->Bool
{
    return lhs.photoID == rhs.photoID
}

