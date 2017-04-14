//
//  ViewController.swift
//  lba.1.tut
//
//  Created by scm197 on 1/7/17.
//  Copyright © 2017 scm197. All rights reserved.
//

import UIKit

class v1Con: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    private let cellType_1 = "cell_1"
    private let cellType_2 = "cell_2"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        collectionView?.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellType_1)
        collectionView?.register(cell_2.self, forCellWithReuseIdentifier: cellType_2)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(section)
        if(section == 0){
            return 4;
        }
        else{
            return 1;
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell: UICollectionViewCell?
        if(indexPath.section == 1)
        {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType_1, for: indexPath)
            cell!.backgroundColor = UIColor.red
        }
        else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType_2, for: indexPath) as! cell_2
        }
       
        return cell!;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 0)
        {
            return CGSize(width: self.view.frame.width - 10 , height: 200)
        }
        else
        {
            return CGSize(width: self.view.frame.width - 20 , height: 70)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if(section == 0){
             return UIEdgeInsetsMake(10, 5, 2.5, 5);
        }
        else{
             return UIEdgeInsetsMake(2.5, 10, 10, 10);
        }
    }
}


class cell_2: UICollectionViewCell , UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout
{
    private var sub_collec_view : UICollectionView!
    private let sub_cell_type_1 = "sub_cell_type_1"
    private let sub_cell_type_2 = "sub_cell_type_2"
    
    override init(frame: CGRect) {
       
        super.init(frame: frame)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        sub_collec_view = UICollectionView(frame: .zero, collectionViewLayout: layout);
        sub_collec_view.backgroundColor = UIColor.purple;
        sub_collec_view.translatesAutoresizingMaskIntoConstraints = false;
        
        sub_collec_view.dataSource = self
        sub_collec_view.delegate = self
        sub_collec_view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.sub_cell_type_2)
        sub_collec_view.register(sub_cell.self, forCellWithReuseIdentifier: self.sub_cell_type_1)
            
        setupViews();
    }

    let dividerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view;
    }()
   
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = " - robots -";
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textAlignment = .center
        label.backgroundColor = UIColor.green
        return label;
   }()
    
  
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    func setupViews()
    {
        self.backgroundColor = UIColor.blue
        self.addSubview(self.nameLabel)
        self.addSubview(self.sub_collec_view);
      
        self.addSubview(self.dividerView)
        
        var constriants : [NSLayoutConstraint] = [];
        
        constriants.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-8-|", options:NSLayoutFormatOptions() , metrics: nil, views: ["v0":sub_collec_view]) );
        
        constriants.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-8-|", options:NSLayoutFormatOptions() , metrics: nil, views: ["v0":nameLabel]) );
        
        constriants.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options:NSLayoutFormatOptions() , metrics: nil, views: ["v0":dividerView]) );
        
        constriants.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|[nameLabel(35)][v0][v1(0.5)]|", options:NSLayoutFormatOptions() , metrics: nil, views: ["v0":sub_collec_view , "v1":self.dividerView , "nameLabel":self.nameLabel]));
        
        NSLayoutConstraint.activate(constriants);
        
    }

   // Data Source and Delegate for the collection view within the cell
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0)
        {
            return 5
        }
        else
        {
            return 1
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if(indexPath.section == 0)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.sub_cell_type_1, for: indexPath) as! sub_cell
            return cell;    
        } 
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.sub_cell_type_2, for: indexPath)
            cell.backgroundColor = UIColor.yellow
            return cell;    
        }
        
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 0)
        {
            return CGSize(width: 120, height: collectionView.frame.height)
        }
        else
        {
            return CGSize(width: 80, height: collectionView.frame.height)
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if(section == 0)
        {
            return UIEdgeInsetsMake(0, 5, 0, 5)
        }else{
            return UIEdgeInsetsMake(0, 5, 0, 5)
        }
    }
    
}


class sub_cell : UICollectionViewCell
{
    var indexText : String!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews();
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    let imageView : UIImageView = {
        let imageName = "gundam"
        let iv = UIImageView(image: UIImage(named: imageName))
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }();
   
    let imageLabel : UILabel = {
            let label = UILabel()
            label.text = " gundam "
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
            return label;
    }()
    
    let fanLabel : UILabel = {
            let label = UILabel()
            label.text = " stardust "
           label.font = UIFont.systemFont(ofSize: 12)
            //label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            return label;
    }()
     
    func setupViews(){
        self.backgroundColor = UIColor.orange
        self.addSubview(imageView)
        imageView.frame = CGRect(x: 5, y: 0, width: self.frame.width - 10 , height: self.frame.width)
        
        self.addSubview(self.imageLabel)
        imageLabel.frame = CGRect(x: imageView.frame.origin.x , y: imageView.frame.height + 2, width: imageView.frame.width, height: 20)
        
        self.addSubview(self.fanLabel)
        fanLabel.frame = CGRect(x: imageView.frame.origin.x, y: imageLabel.frame.origin.y + imageLabel.frame.height  , width: imageView.frame.width, height: 20)
        
    }
    
}

