//
//  ViewController.swift
//  hotels_list
//
//  Created by Georgy on 2025-04-29.
//

import UIKit
import ComposableArchitecture

struct Hotel {
    let name: String
}

@Reducer
struct HotelsReducer {
    @ObservableState
    struct State {
        var hotels: [Hotel] = .init()
    }
    
    enum Action {
        case some
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .some:
                return .none
            }
        }
    }
}

class ViewController: UIViewController {
    private let store: StoreOf<HotelsReducer>
    
    init(store: StoreOf<HotelsReducer>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }


}

