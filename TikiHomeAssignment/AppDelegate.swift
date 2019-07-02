//
//  AppDelegate.swift
//  TikiHomeAssignment
//
//  Created by Phuc Hoang on 7/1/19.
//  Copyright © 2019 Phuc Hoang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let rootViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! ViewController
    let service = Service(webAPI: WebAPI.shared)
    let viewModel = ViewModel(service: service)
    rootViewController.viewModel = viewModel
    self.window?.rootViewController = rootViewController
    self.window?.makeKeyAndVisible()
    return true
  }
}
