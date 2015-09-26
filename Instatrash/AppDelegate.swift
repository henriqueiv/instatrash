//
//  AppDelegate.swift
//  Instatrash
//
//  Created by Henrique Valcanaia on 9/26/15.
//  Copyright © 2015 Instatrash Inc. All rights reserved.
//

import UIKit
import Parse
import Bolts
import FBSDKCoreKit
import ParseFacebookUtilsV4

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let kParseApplicationID = "Vhefw957qbGgxs49ydiuzWt7vWw4llegv3MLF7SR"
    let kParseClientKey = "0UU7Eds0dzATUR7hqtkw5fRkk6PhwRTtYUXvomTA"
    
    func configureParse(launchOptions: [NSObject: AnyObject]?){
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        configureParseForApplication(application, withOptions: launchOptions)
        
        return true
    }
    
    func configureParseForApplication(application:UIApplication, withOptions options: [NSObject:AnyObject]?){
        configureParseRegisterSublasses()
        configureParsePushForApplication(application, withFinishLaunchingWithOptions: options)
        Parse.enableLocalDatastore()
        Parse.setApplicationId(kParseApplicationID, clientKey: kParseClientKey)
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(options)
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(options, block: { (success: Bool, error: NSError?) -> Void in
            if error != nil{
                print(error?.description)
            }
        })
    }
    
    func configureParseRegisterSublasses(){
        Like.registerSubclass()
        Post.registerSubclass()
    }
    
    func configureParsePushForApplication(application: UIApplication, withFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?){
        // Register for Push Notitications
        if application.applicationState != UIApplicationState.Background {
            // Track an app open here if we launch with a push, unless
            // "content_available" was used to trigger a background push (introduced in iOS 7).
            // In that case, we skip tracking here to avoid double counting the app-open.
            
            let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
            let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
            var pushPayload = false
            if let options = launchOptions {
                pushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil
            }
            if (preBackgroundPush || oldPushHandlerOnly || pushPayload) {
                PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: { (suc:Bool, err:NSError?) -> Void in
                    if err != nil{
                        print(err?.localizedDescription)
                    }
                })
            }
        }
        if #available(iOS 8.0, *) {
            let userNotificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
            let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        } else {
            let types: UIRemoteNotificationType = [UIRemoteNotificationType.Badge, UIRemoteNotificationType.Alert, UIRemoteNotificationType.Sound]
            application.registerForRemoteNotificationTypes(types)
        }
    }
}

//MARK: - Facebook
extension AppDelegate {
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    //Make sure it isn't already declared in the app delegate (possible redefinition of func error)
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
}

//MARK: - Push Notifications
extension AppDelegate{
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackgroundWithBlock { (suc: Bool, err: NSError?) -> Void in
            print("deviceToken: \(deviceToken)")
        }
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        if error.code == 3010 {
            print("Push notifications are not supported in the iOS Simulator.")
        } else {
            //            SVProgressHUD.showErrorWithStatus("Erro ao registrar este iPhone para receber notificações! \(error.localizedDescription)", maskType: SVProgressHUDMaskType.Gradient)
            print("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print("didReceiveRemoteNotification: \(userInfo)")
        
        PFPush.handlePush(userInfo)
        if application.applicationState == UIApplicationState.Inactive {
            PFAnalytics.trackAppOpenedWithRemoteNotificationPayloadInBackground(userInfo, block: { (suc:Bool, err:NSError?) -> Void in
                
            })
        }
    }
}