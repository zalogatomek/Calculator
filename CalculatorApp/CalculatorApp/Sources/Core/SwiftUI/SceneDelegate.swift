//
//  SceneDelegate.swift
//  CalculatorApp
//
//  Created by Tomasz Załoga on 09/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Create the SwiftUI view that provides the window contents.
        let calculatorView = CalculatorView()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: calculatorView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
