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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func post(_: AnyObject) {
        let post = Post()
        post.user = PFUser.currentUser()
        post.text = "Va satã!"
        post.image = PFFile(data: UIImagePNGRepresentation(UIImage(named: "imageTest")!)!)
        
        InstatrashAPI.sharedInstance.createPost(post) { (suc:Bool, error:NSError?) -> Void in
            if error == nil{
                print("salvou")
            }else{
                print(error?.localizedDescription)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
