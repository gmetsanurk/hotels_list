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

struct Coordinator {
    func open(hotel: Hotel) {
        
    }
}

let coordinator = Coordinator()

func loadImage() async -> UIImage {
    UIImage(data: Data())!
}

@Reducer
struct HotelsReducer {
    @ObservableState
    struct State {
        var hotels: [Hotel] = .init()
    }
    
    enum Action {
        case hotelSelected(Hotel)
        case imageReceived(UIImage, Hotel)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .hotelSelected(let hotel):
                return .run { send in
                    let image = await loadImage()
                    await send(.imageReceived(image, hotel))
                }
            case .imageReceived(let image, let hotel):
                coordinator.open(hotel: hotel)
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

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        store.state.hotels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        store.send(.hotelSelected(store.state.hotels[indexPath.item]))
    }
}
