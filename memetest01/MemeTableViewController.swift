//
//  MemeTableViewController.swift
//  memetest01
//
//  Created by Cesar Ramirez on 4/26/15.
//  Copyright (c) 2015 Cesar Ramirez. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController{

    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.sharedApplication().delegate as! AppDelegate
        let appDelegate = object as AppDelegate
        memes = appDelegate.memes
        self.tableView.reloadData()
    }
    
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as! UITableViewCell
        let meme = memes[indexPath.row]

        cell.textLabel?.text = meme.textTop
        cell.imageView?.image = meme.image
        
        return cell
        }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")! as! MemeDetailViewController
        detailController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }

}

