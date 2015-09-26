//
//  PostViewController.swift
//  Instatrash
//
//  Created by Henrique Valcanaia on 9/26/15.
//  Copyright © 2015 Instatrash Inc. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var retakeButton: UIButton!
    
    private let picker = UIImagePickerController()
    private var didAppearOnce = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        retakeButton.layer.cornerRadius = 8
        retakeButton.layer.borderWidth = 1
        retakeButton.layer.borderColor = retakeButton.tintColor.CGColor
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        retakeButton.hidden = true
        if !didAppearOnce{
            takePhoto()
        }
    }
    
    @IBAction func retakePhoto(sender: AnyObject) {
        takePhoto()
    }
    func takePhoto(){
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.cameraCaptureMode = .Photo
            presentViewController(picker, animated: true, completion: nil)
            didAppearOnce = true
        } else {
            noCamera()
        }
    }
    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func post(_: AnyObject) {
        let post = Post()
        post.user = PFUser.currentUser()
        post.text = "Va satã!"
        let data = UIImageJPEGRepresentation(imageView.image!, 0.5)!
        print(data.length)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "YYYY-MM-DDhhmmss"
        let fileName = formatter.stringFromDate(NSDate())
        post.image = PFFile(name: fileName, data: data, contentType: "image/png")
        InstatrashAPI.sharedInstance.createPost(post) { (suc:Bool, error:NSError?) -> Void in
            if error == nil{
                self.dismissViewControllerAnimated(true, completion: nil)
            }else{
                print(error?.localizedDescription)
            }
        }
    }
    
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension PostViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageView.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
        retakeButton.hidden = false
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = chosenImage
            retakeButton.hidden = false
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
