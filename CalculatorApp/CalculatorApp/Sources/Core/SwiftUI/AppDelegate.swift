//
//  AppDelegate.swift
//  CalculatorApp
//
//  Created by Tomasz Załoga on 09/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let configurationName: String = "CalculatorApp Configuration"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: configurationName, sessionRole: connectingSceneSession.role)
    }
}
