//
//  ViewController.swift
//  Meme_prep
//
//  Created by Taiowa Waner on 3/29/15.
//  Copyright (c) 2015 Taiowa Waner. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: - Outlets and properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var memedImage: UIImage?
    let topPlaceholder = "Top"
    let bottomPlaceholder = "Bottom"
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.whiteColor(),
        NSForegroundColorAttributeName : UIColor.blackColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : 10.0,
//        NSTextAlignment: NSTextAlignment.Center
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        self.textField.backgroundColor = UIColor.clearColor()
        self.bottomTextField.delegate = self
        self.bottomTextField.backgroundColor = UIColor.clearColor()
        self.textField.defaultTextAttributes = memeTextAttributes
        self.bottomTextField.defaultTextAttributes = memeTextAttributes
        self.textField.textAlignment = .Center
        self.bottomTextField.textAlignment = .Center
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Check if camera is available
        self.cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        // Suscribe to keyboardNotifications
        self.subscribeToKeyboardNotification()
        // Set default text
        self.textField.text = self.topPlaceholder
        self.bottomTextField.text = self.bottomPlaceholder
        // Disable share button
        self.shareButton.enabled = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pickTapped(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
        } else if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            //Enable Share Button
            self.shareButton.enabled = true
        })
    }
    
    // MARK: - UITextFieldDelegate methods
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    // MARK: - Keyboard helpers
    
    /** 
    Subscribe and Unsubscribe
    */
    func subscribeToKeyboardNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardFrameWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    /**
    Helper methods
    */
    
    /// Notification for when keyboardShows. Moves frame up
    func keyboardWillShow(notification: NSNotification){
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    /// Notification for when keyboardHides. Moves frame down
    func keyboardFrameWillHide(notifcation: NSNotification){
        self.view.frame.origin.y += getKeyboardHeight(notifcation)
    }
    /// Notification for getting the height of the keyboard
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue
        return keyboardSize.CGRectValue().height
    }
    
    /**
    Memed Image helper methods will go here. These will assist in generating; saving the meme.
    */
    
    // MARK: - Memed Image helpers
    
    
    ///
    /// Hides or shows the Navbar and Toolbar based on param.
    ///
    ///:param: action to determine whether to hide or show the bars.
    func showHideBars(action: Bool) {
        navigationController?.navigationBarHidden = action
        self.toolbar.hidden = action
    }
    
    func save() {
        //let memedImage = generateMemedImage()
        var meme = Meme(bottomText: textField.text!, topText: bottomTextField.text!, image: imageView.image!, memedImage:self.memedImage!)
        (UIApplication.sharedApplication().delegate as AppDelegate).memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        
        // Hide tool and navbar
        self.showHideBars(true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // save the Memed image
        
        // Show tool and nav bar
        self.showHideBars(false)
        
        return memedImage
    }
    
    // MARK: - Share Image
    
    @IBAction func shareButtonTapped(sender: UIBarButtonItem) {
        
    }

    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.memedImage = generateMemedImage()
        self.save()
        self.imageView.image = self.memedImage    }
    
    @IBAction func testHiddenTapped(sender: UIButton) {
       println("Thing was tapped")
    }
    
    
}

