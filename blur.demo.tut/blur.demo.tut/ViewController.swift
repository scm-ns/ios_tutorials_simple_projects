//
//  ViewController.swift
//  blur.demo.tut
//
//  Created by scm197 on 3/31/17.
//  Copyright © 2017 scm197. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func loadView()
    {
        self.view = UIView(frame :UIScreen.main.bounds)
       
        // content view
        self.view.addSubview(self.createContentView())
        
        
        // header view
        self.view.addSubview(self.createHeaderView())
        
        // slide view
        self.view.addSubview(self.createSlideView())
        
        
    }
    
    private func createScrollView() -> UIView
    {
        let containerView = UIView(frame: self.view.frame)
        
        let blurImg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 568))
        blurImg.contentMode = .scaleAspectFill
        containerView.addSubview(blurImg)
       
        let scrollView = UIScrollView(frame: self.view.frame)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 2 - 110)
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        
        let slideContentView = UIView(frame: CGRect(x: 0, y: 518, width: self.view.frame.width, height: 508))
        slideContentView.backgroundColor = UIColor.clear
        scrollView.addSubview(slideContentView)
       
        let slideUpLabel = UILabel(frame: CGRect(x: 0, y: 6, width: self.view.frame.width, height: 50))
        slideUpLabel.text = "blah blah blah"
        slideUpLabel.font =  UIFont(name: "HelveticaNeue", size: 20)
        slideUpLabel.textColor = UIColor(white: 0.4, alpha: 1)
        slideUpLabel.textAlignment = .center
        slideContentView.addSubview(slideUpLabel)
       
        //let imageView =
        
        
        
    }
    
    
    
    private func createHeaderView() -> UIView
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        headerView.backgroundColor = UIColor(red: 229/255, green: 39/255, blue: 34/255, alpha: 1)
        
        let label = UILabel(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 40))
        label.text = "Dyna blah"
        label.font =
            UIFont(name: "HelveticaNeue", size: 20)
        label.textColor = UIColor(white: 0.4, alpha: 1)
        label.textAlignment = .center
        headerView.addSubview(label)
       
        return headerView
    }
    
    
    private func createContentView() -> UIView
    {
       let contentView = UIView(frame: self.view.frame)
        
       let contentImage = UIImageView(frame: contentView.frame)
       contentImage.image = UIImage(named: "demo-bg")
       contentView.addSubview(contentImage)
       
       let metaContainer = UIView(frame: CGRect(x: self.view.frame.width / 2 - 65  , y: 335, width: 130, height: 130))
       metaContainer.backgroundColor = UIColor.white
       metaContainer.layer.cornerRadius = 65
       contentView.addSubview(metaContainer)
       
        
        let photoTitle = UILabel(frame : CGRect(x: 0, y: 54, width: 130, height: 18))
        photoTitle.text = "blah blah"
        photoTitle.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        photoTitle.textAlignment = .center
        photoTitle.textColor = UIColor(white: 0.4, alpha: 1)
        metaContainer.addSubview(photoTitle)
        
        let photographer = UILabel(frame : CGRect(x: 0, y: 72, width: 130, height: 18))
        photographer.text = "blah blah"
        photographer.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        photographer.textAlignment = .center
        photographer.textColor = UIColor(white: 0.4, alpha: 1)
        metaContainer.addSubview(photographer)
       
        return contentView
        
    }
    
}


extension ViewController : UIScrollViewDelegate
{
    
}

