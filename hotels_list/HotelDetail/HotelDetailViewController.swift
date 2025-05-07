//
//  HotelDetailViewController.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-06.
//
import UIKit
import ComposableArchitecture

class HotelDetailViewController: UIViewController {
    var coordinator: Coordinator?
    private let store: StoreOf<HotelDetailReducer>
    private let viewStore: ViewStore<HotelDetailReducer.State, HotelDetailReducer.Action>
    
    init(store: StoreOf<HotelDetailReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: {$0})
        super.init(nibName:nil, bundle:nil)
    }
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}
