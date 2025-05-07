//
//  HotelsListViewController.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-06.
//

import UIKit
import ComposableArchitecture

extension DependencyValues {
    var dataSource: any DataSource {
        get { self[DataSourceKey.self] }
        set { self[DataSourceKey.self] = newValue }
    }

    private enum DataSourceKey: DependencyKey {
      static let liveValue: any DataSource = iMofasNetworkManager()
    }
}

extension DependencyValues {
    var localStorage: any LocalDataSource {
        get { self[LocalDataSourceKey.self] }
        set { self[LocalDataSourceKey.self] = newValue }
    }

    private enum LocalDataSourceKey: DependencyKey {
      static let liveValue: any LocalDataSource = SomeLocal()
    }
}

let coordinator = Coordinator()

//MARK: - ViewController

class HotelsListViewController: UIViewController {
    private let store: StoreOf<HotelsListReducer>
    private let viewStore: ViewStore<HotelsListState, HotelsListAction>
    
    private lazy var hotelListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width - 32, height: 80)
        layout.minimumLineSpacing = 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.register(HotelCell.self, forCellWithReuseIdentifier: HotelCell.reuseID)
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    init(store: StoreOf<HotelsListReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: {$0})
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeDataSource()
        
        view.backgroundColor = .white
        store.send(.start)
    }
}

extension HotelsListViewController {
    func observeDataSource() {
        observe { [weak self] in
            // self?.tableView.reloadData()
            print(self?.store.state.hotels)
        }
    }
}

extension HotelsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        store.state.hotels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}

extension HotelsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        store.send(.hotelSelected(store.state.hotels[indexPath.item].hotel))
    }
}
