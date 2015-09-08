//
//  AppDelegate.swift
//  Router
//
//  Created by Parveen Kaler on 9/7/15.
//  Copyright © 2015 Smartful Studios Inc. All rights reserved.
//

import UIKit
import SmartRouter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let router: SmartRouter.Router = Router()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        router.route("foo") { _ in
            print("Matched")
        }
        return true
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        return false
    }
}

