//
//  AppDelegate.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 10/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import UIKit
import ReSwift

var store = Store<AppState>(reducer: appReducer, state: nil)

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let launch = LaunchScreenViewController()

        window!.rootViewController = launch
        window?.addSubview(launch.view)
        
        window!.makeKeyAndVisible()
        return true
    }

}

