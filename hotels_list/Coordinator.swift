//
//  Coordinator.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-06.
//

import UIKit
import ComposableArchitecture


@MainActor
protocol Coordinator: Sendable {
    func start()
    func openHotelDetail(_ summary: HotelSummary)
}

@MainActor
final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let navigationController: UINavigationController

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        let listStore = StoreOf<HotelsListReducer>(
            initialState: .init(),
            reducer: { HotelsListReducer() }
        )
        let listVC = HotelsListViewController(store: listStore)
        listVC.coordinator = self

        navigationController.setViewControllers([listVC], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func openHotelDetail(_ summary: HotelSummary) {
        let detailStore = StoreOf<HotelDetailReducer>(
            initialState: .init(summary: summary),
            reducer: { HotelDetailReducer() }
        )
        let detailVC = HotelDetailViewController()//store: detailStore)
        detailVC.coordinator = self
        navigationController.pushViewController(detailVC, animated: true)
    }
}
