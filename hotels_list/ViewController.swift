//
//  ViewController.swift
//  hotels_list
//
//  Created by Georgy on 2025-04-29.
//

import UIKit
import ComposableArchitecture

protocol DataSource {
    func fetchHotels() async throws -> [Hotel]
}

struct SomeAPIDataSource: DataSource {
    func fetchHotels() async throws -> [Hotel] {
        [.init(name: "Hello")]
    }
}

extension DependencyValues {
    var dataSource: any DataSource {
        get { self[DataSourceKey.self] }
        set { self[DataSourceKey.self] = newValue }
    }

    private enum DataSourceKey: DependencyKey {
      static let liveValue: any DataSource = SomeAPIDataSource()
    }
}

struct Hotel: Equatable {
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
struct HotelReducer {
    @ObservableState
    struct State: Identifiable, Equatable {
        var id = UUID()
        var hotel: Hotel = .init(name: "")
    }
    
    enum Action {
        case some
    }

    var body: some Reducer<State, Action> {
        EmptyReducer()
    }
}

@Reducer
struct HotelsReducer {
    @ObservableState
    struct State {
        var hotels: IdentifiedArrayOf<HotelReducer.State> = .init()
    }
    
    enum Action {
        case start
        case hotelsLoaded([Hotel])
        case hotelSelected(Hotel)
        case imageReceived(UIImage, Hotel)
    }
    
    @Dependency(\.dataSource) var dataSource
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .start:
                return .run { send in
                    let hotels = try await dataSource.fetchHotels()
                    await send(.hotelsLoaded(hotels))
                }
            case .hotelsLoaded(let hotels):
                state.hotels = IdentifiedArrayOf<HotelReducer.State>(hotels.map {
                    .init(hotel: $0)
                })
                return .none
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

        observe { [weak self] in
            // self?.tableView.reloadData()
            print(self?.store.state.hotels)
        }
        
        view.backgroundColor = .white
        store.send(.start)
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
        store.send(.hotelSelected(store.state.hotels[indexPath.item].hotel))
    }
}
