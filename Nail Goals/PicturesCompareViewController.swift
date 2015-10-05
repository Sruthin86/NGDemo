//
//  PicturesCompareViewController.swift
//  Nail Goals
//
//  Created by Sparty on 6/7/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class PicturesCompareViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell =  collectionView.dequeueReusableCellWithReuseIdentifier("PicturesCompareCell", forIndexPath: indexPath) as! PicturesCompareCollectionViewCell
        return cell
        
        
        
        
        
        
    }


}
