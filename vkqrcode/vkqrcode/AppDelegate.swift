//
//  AppDelegate.swift
//  vkqrcode
//
//  Created by Александр on 25.04.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let mainVC = MainViewController.init(nibName: nil, bundle: nil)
        let navVC = UINavigationController.init(rootViewController: mainVC)
        self.window?.rootViewController = navVC
        
        return true
    }

}

