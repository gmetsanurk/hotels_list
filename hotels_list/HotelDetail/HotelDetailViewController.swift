//
//  HotelDetailViewController.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-06.
//
import UIKit
import Combine
import ComposableArchitecture

class HotelDetailViewController: UIViewController {
    
    var coordinator: Coordinator?
    private let store: StoreOf<HotelDetailReducer>
    private let viewStore: ViewStore<HotelDetailReducer.State, HotelDetailReducer.Action>
    private var cancellables: Set<AnyCancellable> = []
    
    private var imageView = UIImageView()
    private let nameLabel = UILabel.makeHeadline()
    private let addressLabel = UILabel.makeSubheadline()
    private let starsLabel = UILabel.makeBody()
    private let distanceLabel = UILabel.makeBody()
    private let suitesLabel = UILabel.makeBody()
    private let latitudeLabel = UILabel.makeBody()
    private let longitudeLabel = UILabel.makeBody()
    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .large)
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()
    
    init(store: StoreOf<HotelDetailReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgroundColor
        title = viewStore.summary.name ?? "Hotel Details"
        createImageView()
        setupSubviews()
        bindViewStore()
        
        viewStore.send(.onAppear)
    }
    
    private func bindViewStore() {
        viewStore.publisher.hotel
            .receive(on: RunLoop.main)
            .sink { [weak self] hotelDetail in
                guard let self = self else { return }
                
                let summary = hotelDetail.hotelSummary
                self.nameLabel.text = summary.name
                self.addressLabel.text = summary.address
                if let stars = summary.stars {
                    self.starsLabel.text = String(format: "%.1f ★", stars)
                } else {
                    self.starsLabel.text = "No rating"
                }
                if let dist = summary.distance {
                    self.distanceLabel.text = String(format: "%.1f km away", dist)
                } else {
                    self.distanceLabel.text = "Distance N/A"
                }
                self.suitesLabel.text = "Suites: \(summary.suitesAvailability ?? "-")"
                
                self.latitudeLabel.text = String(format: "Latitude: %.6f", hotelDetail.lat)
                self.longitudeLabel.text = String(format: "Longitude: %.6f", hotelDetail.lon)
            }
            .store(in: &cancellables)
        
        viewStore.publisher.image
            .receive(on: RunLoop.main)
            .sink { [weak self] imageOpt in
                guard let self = self, let image = imageOpt else { return }
                let cropped = image.removingBorder(pixels: 1)
                self.imageView.image = cropped
            }
            .store(in: &cancellables)
        
        viewStore.publisher.isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupSubviews() {
        [
            imageView,
            nameLabel,
            addressLabel,
            starsLabel,
            distanceLabel,
            suitesLabel,
            latitudeLabel,
            longitudeLabel,
            activityIndicator
        ].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            // Image
            imageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: AppGeometry.HotelDetailScreen.topImagePadding
            ),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(
                equalToConstant: AppGeometry.HotelDetailScreen.imageHeight
            ),
            
            // Name
            nameLabel.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: AppGeometry.HotelDetailScreen.verticalSpacing
            ),
            nameLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: AppGeometry.HotelDetailScreen.horizontalPadding
            ),
            nameLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -AppGeometry.HotelDetailScreen.horizontalPadding
            ),
            
            // Address
            addressLabel.topAnchor.constraint(
                equalTo: nameLabel.bottomAnchor,
                constant: AppGeometry.HotelDetailScreen.verticalSpacing
            ),
            addressLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            // Stars
            starsLabel.topAnchor.constraint(
                equalTo: addressLabel.bottomAnchor,
                constant: AppGeometry.HotelDetailScreen.verticalSpacing
            ),
            starsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            // Distance
            distanceLabel.topAnchor.constraint(
                equalTo: starsLabel.bottomAnchor,
                constant: AppGeometry.HotelDetailScreen.verticalSpacing
            ),
            distanceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            // Suites
            suitesLabel.topAnchor.constraint(
                equalTo: distanceLabel.bottomAnchor,
                constant: AppGeometry.HotelDetailScreen.verticalSpacing
            ),
            suitesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            // Latitude
            latitudeLabel.topAnchor.constraint(
                equalTo: suitesLabel.bottomAnchor,
                constant: AppGeometry.HotelDetailScreen.coordinateTopSpacing
            ),
            latitudeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            // Longitude
            longitudeLabel.topAnchor.constraint(
                equalTo: latitudeLabel.bottomAnchor,
                constant: AppGeometry.HotelDetailScreen.coordinateTopSpacing
            ),
            longitudeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            // Activity indicator
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        ])
    }
    
    private func createImageView() {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        imageView = iv
    }
}

private extension UILabel {
    static func makeHeadline() -> UILabel {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 24)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
    static func makeSubheadline() -> UILabel {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16)
        lbl.textColor = .secondaryLabel
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
    static func makeBody() -> UILabel {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
}

private extension UIImage {
    func removingBorder(pixels: CGFloat = 1.0) -> UIImage {
        let scale = self.scale
        let inset = pixels / scale
        let width = size.width - inset * 2
        let height = size.height - inset * 2
        let cropRect = CGRect(
            x: inset * scale,
            y: inset * scale,
            width: width * scale,
            height: height * scale
        )
        guard
            let cgImage = self.cgImage?.cropping(to: cropRect)
        else { return self }
        return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
    }
}
