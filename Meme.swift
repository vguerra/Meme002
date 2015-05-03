//
//  Meme.swift
//  memetest01
//
//  Created by Cesar Ramirez on 4/19/15.
//  Copyright (c) 2015 Cesar Ramirez. All rights reserved.
//

import Foundation
import UIKit

struct  Meme {
    
    var memes = [Meme]()
 
    var textTop: String
    var textBottom: String
    var image: UIImage
    var memedImage : UIImage
    

    
    init (textTop: String, textBottom: String, image: UIImage, memedImage: UIImage){
        self.textTop = textTop
        self.textBottom = textBottom
        self.image = image
        self.memedImage = memedImage
    }
    

}



    
