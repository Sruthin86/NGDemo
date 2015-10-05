//
//  PicturesOfYourProgressViewController.swift
//  Nail Goals
//
//  Created by Sparty on 6/4/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class PicturesOfYourProgressViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
       
            var cell =  collectionView.dequeueReusableCellWithReuseIdentifier("PicturesCell", forIndexPath: indexPath) as! PicturesCollectionViewCell
            return cell
       
        
        
        
        
        
    }
    


    

}
