//
//  AppDelegate.swift
//  test
//
//  Created by Максим Окунеев on 12/19/19.
//  Copyright © 2019 Максим Окунеев. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var bgSessionCompletionHandler: (() -> ())?
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
            bgSessionCompletionHandler = completionHandler
    }
    
    
}

