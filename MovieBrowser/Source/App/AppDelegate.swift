//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //iOS 15 issue with transparent background for navigation bar. this works for light and dark mode.
        ///https://developer.apple.com/forums/thread/682420
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor(red: 46.0/255.0, green: 150/255.0, blue: 254.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        return true
    }
}
