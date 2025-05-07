//
//  AppDelegate.swift
//  hotels_list
//
//  Created by Georgy on 2025-04-29.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var coordinator: Coordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let appCoordinator = AppCoordinator(window: window)
        self.coordinator = appCoordinator
        appCoordinator.start()

        return true
    }
}

