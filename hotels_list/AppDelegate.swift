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
    
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        setupWindow()
        return true
    }
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeVC = HotelsListViewController(store: .init(initialState: .init(), reducer: {
            HotelsListReducer()
        }))
        window?.rootViewController = homeVC
        window?.makeKeyAndVisible()
    }
}

