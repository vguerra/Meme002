//
//  ViewController.swift
//  memetest01
//
//  Created by Cesar Ramirez on 4/5/15.
//  Copyright (c) 2015 Cesar Ramirez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var Camera: UIButton!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -5.0
    ]
    
    override func viewWillAppear(animated: Bool) {
        
        self.subscribeToKeyboardNotifications()
        
        Camera.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)

        topText.defaultTextAttributes  = memeTextAttributes
        topText.text = "TOP"
        topText.textAlignment = NSTextAlignment.Center
        bottomText.defaultTextAttributes  = memeTextAttributes
        bottomText.text = "BOTTOM"
        bottomText.textAlignment = NSTextAlignment.Center
        
        self.topText.delegate = self
        self.bottomText.delegate = self
    
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
   }
    
    @IBAction func pickAnImageFromCamera (sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker:UIImagePickerController){
        println("dismissing imagepicker")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo  info: [NSObject : AnyObject]) {
       
        imagePickerView.contentMode = UIViewContentMode.ScaleAspectFill
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }

    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification:NSNotification){
      self.view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        if bottomText.editing {
            return keyboardSize.CGRectValue().height
        }
        else {
            return 0
        }
    }
    
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:" , name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardDidHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidHideNotification, object: nil)
    }
    
    func save() {
   
       var meme = Meme(textTop: topText.text!, textBottom: bottomText.text!,image:
           imagePickerView.image!, memedImage:memedImage())
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }
    
    func memedImage() -> UIImage {
        
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.toolbarHidden = true

        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.toolbarHidden = false
        
        return memedImage
    }
    
    @IBAction func share(sender: UIBarButtonItem) {
        let memedImage = self.memedImage()
        let avc = UIActivityViewController(activityItems: [memedImage] , applicationActivities: nil)
        
        avc.completionWithItemsHandler = {
            (s: String!, ok: Bool, items: [AnyObject]!, err:NSError!) -> Void in
            self.save()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        presentViewController(avc, animated: true, completion: nil)
    }
    
}




































