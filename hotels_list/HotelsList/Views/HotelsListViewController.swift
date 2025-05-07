//
//  HotelsListViewController.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-06.
//

import UIKit
import ComposableArchitecture

let collectionViewMagicNumber: CGFloat = 16

//MARK: - ViewController

class HotelsListViewController: UIViewController {
    var coordinator: Coordinator?
    
    private let store: StoreOf<HotelsListReducer>
    private let viewStore: ViewStore<HotelsListState, HotelsListAction>
    
    private lazy var hotelsListCollectionView: UICollectionView = {
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
        view.backgroundColor = .white
        title = "Hotels"
        setupSubviews()
        observeDataSource()
        
        store.send(.start)
    }
}

extension HotelsListViewController {
    func observeDataSource() {
        observe { [weak self] in
            self?.hotelsListCollectionView.reloadData()
            print(self?.store.state.hotels)
        }
    }
    
    private func setupSubviews() {
        view.addSubview(hotelsListCollectionView)
        hotelsListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hotelsListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: collectionViewMagicNumber),
            hotelsListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewMagicNumber),
            hotelsListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewMagicNumber),
            hotelsListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -collectionViewMagicNumber)
        ])
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension HotelsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        store.state.hotels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotelCell.reuseID, for: indexPath) as! HotelCell
        let viewStoreHotel = viewStore.hotels[indexPath.item].hotel
        let summary = viewStoreHotel.hotelSummary
        cell.configure(with: summary)
        return cell
    }
}

extension HotelsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        store.send(.hotelSelected(store.state.hotels[indexPath.item].hotel))
    }
}
