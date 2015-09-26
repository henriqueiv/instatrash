//
//  LoginViewController.swift
//  Instatrash
//
//  Created by William Hass on 9/26/15.
//  Copyright © 2015 Instatrash Inc. All rights reserved.
//

import UIKit
import SVProgressHUD
import Parse
import ParseFacebookUtilsV4

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(ParseFacebookUtilsV4VersionNumber)
    }
    
    // MARK: IBActions
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        
    }
    
    @IBAction func loginWithFacebook(sender: AnyObject) {
//        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Gradient)
//        SVProgressHUD.showWithStatus("Entrando...")
//        let facebookPermissions = ["email", "public_profile", "user_friends"];
//        PFFacebookUtils.logInInBackgroundWithReadPermissions(facebookPermissions) { (user: PFUser?, error: NSError?) -> Void in
//            if let user = user {
//                if user.isNew {
//                    print("User signed up and logged in through Facebook!")
//                } else {
//                    print("User logged in through Facebook!")
//                }
//                SVProgressHUD.showWithStatus("Buscando dados do Facebook...")
//                self.loadDataFromFacebook({ (suc:Bool, error:NSError?) -> Void in
//                    SVProgressHUD.dismiss()
//                    if error == nil {
//                        let storyboard = UIStoryboard(name: "Login", bundle: nil)
//                        let vc = storyboard.instantiateViewControllerWithIdentifier("LeagueVC") as! UINavigationController
//                        self.presentViewController(vc, animated: true, completion: nil)
//                    } else {
//                        print(error)
//                    }
//                })
//            } else {
//                SVProgressHUD.showErrorWithStatus("Ocorreu um erro ao entrar :( \n \(error?.localizedDescription)")
//            }
//        }
    }
    
    func loadDataFromFacebook(completionBlock:PFBooleanResultBlock){
        if ((FBSDKAccessToken.currentAccessToken()) != nil){
            let request = FBSDKGraphRequest(graphPath: "me", parameters: nil)
            request.startWithCompletionHandler({ (connection, result, error) -> Void in
                if error == nil {
                    print(result)
                    let data = result as! NSDictionary
                    let user = PFUser.currentUser()!
                    user.username = data["name"] as? String
                    user.saveInBackgroundWithBlock({ (result, error) -> Void in
                        completionBlock(result, error)
                    })
                } else {
                    completionBlock(false, error)
                }
            })
        }else{
            let error = NSError(domain: "io.instrash", code: 1, userInfo: [NSLocalizedDescriptionKey:"Access token de acesso ao Facebook está nil"])
            completionBlock(false, error)
        }
        
    }
    
}
