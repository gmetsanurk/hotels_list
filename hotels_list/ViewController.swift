//
//  ViewController.swift
//  hotels_list
//
//  Created by Georgy on 2025-04-29.
//

import UIKit
import ComposableArchitecture

// TODO: a separate file for DataSource
protocol DataSource {
    func fetchHotelList() async throws -> [HotelSummary]
    func fetchHotelDetail(id: Int) async throws -> HotelDetail
    func fetchImageData(fileName: String) async throws -> Data
}

// TODO: you can use this for tests
struct SomeAPIDataSource: DataSource {
    func fetchHotelList() async throws -> [HotelSummary] {
        [.init(id: .init(), name: "some name", address: "", stars: nil, distance: 0, suitesAvailability: "")]
    }
    
    func fetchHotelDetail(id: Int) async throws -> HotelDetail {
        .init(hotelSummary: .init(id: .init(), name: "", address: "", stars: nil, distance: 0, suitesAvailability: ""), image: nil, latitude: 0, longitude: 0)
    }
    
    func fetchImageData(fileName: String) async throws -> Data {
        .init()
    }
}

extension DependencyValues {
    var dataSource: any DataSource {
        get { self[DataSourceKey.self] }
        set { self[DataSourceKey.self] = newValue }
    }

    private enum DataSourceKey: DependencyKey {
      static let liveValue: any DataSource = NetworkManager()
    }
}

// TODO: a separate file for Coordinator
struct Coordinator {
    func open(hotel: Hotel) {
        
    }
}

let coordinator = Coordinator()

class ViewController: UIViewController {
    private let store: StoreOf<HotelsListReducer>
    
    init(store: StoreOf<HotelsListReducer>) {
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
