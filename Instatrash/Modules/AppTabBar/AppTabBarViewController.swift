//
//  AppTabBarViewController.swift
//  Instatrash
//
//  Created by Henrique Valcanaia on 9/26/15.
//  Copyright © 2015 Instatrash Inc. All rights reserved.
//

import UIKit

class AppTabBarViewController: UITabBarController , UITabBarControllerDelegate {
    
    @IBOutlet var postTabBarItem:UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        
        if viewController.restorationIdentifier == "post" {
            self.performSegueWithIdentifier("Post", sender: self)
            return false
        }
        
        return true
    }
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        
    }
    
}
