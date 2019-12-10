//
//  AppDelegate.swift
//  CalculatorApp
//
//  Created by Omek on 02/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let calculatorViewController = CalculatorViewControllerRx(viewModel: CalculatorViewModelRx())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = calculatorViewController
        window?.makeKeyAndVisible()
        return true
    }
}
