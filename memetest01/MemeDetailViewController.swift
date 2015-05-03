//
//  MemeDetailViewController.swift
//  memetest01
//
//  Created by Cesar Ramirez on 4/25/15.
//  Copyright (c) 2015 Cesar Ramirez. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var memeImage: UIImageView!

    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {

        super.viewWillAppear(animated)
        self.memeImage!.image = meme.memedImage
    
    }
    
}



