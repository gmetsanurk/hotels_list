//
//  HotelsListViewController.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-06.
//

import UIKit
import ComposableArchitecture
import Combine

class HotelsListViewController: UIViewController {
    private let store: StoreOf<HotelsListReducer>
    private let viewStore: ViewStore<HotelsListState, HotelsListAction>
    var coordinator: Coordinator?
    
    private var cancellables = Set<AnyCancellable>()
    
    private enum SortType: Int {
        case server = 0, distance, availability
    }
    private lazy var sortControl = UISegmentedControl()
    
    private var currentSort: SortType = .server {
        didSet { hotelsListCollectionView.reloadData() }
    }
    
    private lazy var hotelsListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width - 32, height: 80)
        layout.minimumLineSpacing = 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate   = self
        cv.register(HotelCell.self, forCellWithReuseIdentifier: HotelCell.reuseID)
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    init(store: StoreOf<HotelsListReducer>) {
        self.store     = store
        self.viewStore = ViewStore(store, observe: { $0 })
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgroundColor
        createSegmentedControl()
        navigationItem.titleView = sortControl
        
        setupSubviews()
        observeDataSource()
        
        viewStore.send(.start)
    }
    
    @objc private func sortChanged(_ sc: UISegmentedControl) {
        guard let newSort = SortType(rawValue: sc.selectedSegmentIndex) else { return }
        currentSort = newSort
    }
    
    var displayedHotels: [HotelDetailReducer.State] {
        let originals = viewStore.state.listOfHotels.map { $0 }
        switch currentSort {
        case .server:
            return originals
        case .distance:
            return originals.sorted {
                ($0.summary.distance ?? 0) < ($1.summary.distance ?? 0)
            }
        case .availability:
            return originals.sorted {
                let l = Int($0.summary.suitesAvailability ?? "") ?? 0
                let r = Int($1.summary.suitesAvailability ?? "") ?? 0
                return l > r
            }
        }
    }
    
    func observeDataSource() {
        viewStore.publisher.isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                self.activityIndicator.center = self.view.center
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
            .store(in: &cancellables)
        
        viewStore.publisher.listOfHotels
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.hotelsListCollectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    func createSegmentedControl() {
        let sc = UISegmentedControl(items: ["Server", "Distance", "Suites"])
        sc.selectedSegmentIndex = SortType.server.rawValue
        sc.addTarget(self, action: #selector(sortChanged(_:)), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sortControl = sc
    }
    
    private func setupSubviews() {
        view.addSubview(hotelsListCollectionView)
        hotelsListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          hotelsListCollectionView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: AppGeometry.HotelsListScreen.verticalPadding
          ),
          hotelsListCollectionView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: AppGeometry.HotelsListScreen.horizontalPadding
          ),
          hotelsListCollectionView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -AppGeometry.HotelsListScreen.horizontalPadding
          ),
          hotelsListCollectionView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -AppGeometry.HotelsListScreen.verticalPadding
          ),
        ])

        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
      }
}
 

    


