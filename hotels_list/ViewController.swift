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
        [.init(
          hotelSummary: .init(
            id: UUID(),
            name: "–",
            address: "–",
            stars: nil,
            distance: 0,
            suitesAvailability: []
          ),
          image: nil,
          latitude: 0,
          longitude: 0
        )]
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

struct Coordinator {
    func open(hotel: Hotel) {
        
    }
}

let coordinator = Coordinator()

func loadImage() async -> UIImage {
    UIImage(data: Data())!
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
