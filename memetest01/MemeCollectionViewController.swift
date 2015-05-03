//
//  MemeCollectionViewController.swift
//  memetest01
//
//  Created by Cesar Ramirez on 4/23/15.
//  Copyright (c) 2015 Cesar Ramirez. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDataSource{

    var memes: [Meme]!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.sharedApplication().delegate as! AppDelegate
        let appDelegate = object as AppDelegate
        memes = appDelegate.memes
        
        //self.collectionView?.reloadData()
    }

     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }

     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        
        let meme = self.memes[indexPath.row]

//        cell.topCellText.text = meme.textTop
//        cell.bottomText.text = meme.textBottom
          cell.memedImage = meme.memedImage

        return cell
    }
    
     func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("memeDetailViewController")! as! MemeDetailViewController
        
        detailController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
}
