//
//  ViewController.swift
//  clview.tut
//
//  Created by scm197 on 10/24/16.
//  Copyright © 2016 scm197. All rights reserved.
//

import UIKit


let defaultCell : String = "cell"


class ViewController: UIViewController {
    // Try adding a collection view to the screen using the visual format
    var clv : UICollectionView? = nil
    var clvLayout : UICollectionViewFlowLayout?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       // create the layout to be used by the collection view
        self.clvLayout = UICollectionViewFlowLayout.init()
        clvLayout?.itemSize = CGSizeMake(100, 100)
        clvLayout?.scrollDirection = .Vertical
        
        // create the collection view
        self.clv = UICollectionView(frame: self.view.frame, collectionViewLayout: clvLayout!)
        clv?.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(clv!)
     
        // set the colors to distinguish between them 
        self.view.backgroundColor = UIColor.blueColor()
        clv?.backgroundColor = UIColor.redColor()
       
        // set the constraints that will contraint both of the views
        var clvContrainsts = [NSLayoutConstraint]()
        let hContraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[clv]-15-|", options: [], metrics: nil, views: ["clv" : clv!])
        let vContraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|-15-[clv]-15-|", options: [], metrics: nil, views: ["clv" : clv!])
        clvContrainsts += hContraint
        clvContrainsts += vContraint
        NSLayoutConstraint.activateConstraints(clvContrainsts)
        
        
        // add a cell to the collection view for test purposes
        self.clv?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: defaultCell)
       
        // set data source and delegate of the collection view to be self
        self.clv?.delegate = self ; self.clv?.dataSource = self

        // add bounce feature
        self.clv?.alwaysBounceVertical = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 10 ;
    }
    
   
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell  = (self.clv?.dequeueReusableCellWithReuseIdentifier(defaultCell, forIndexPath: indexPath))!
     
        cell.contentView.backgroundColor = UIColor.blackColor()
       
        return cell
    }
}
