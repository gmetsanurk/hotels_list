//
//  HotelSummaryCell.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-06.
//

import UIKit

class HotelCell: UICollectionViewCell {
    static let reuseID = "HotelCell"
    private let nameLabel = UILabel()
    private let distanceLabel = UILabel()
    private let availabilityLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.numberOfLines = 2
        distanceLabel.font = .systemFont(ofSize: AppGeometry.HotelsListScreen.cellFontSize)
        availabilityLabel.font = .systemFont(ofSize: AppGeometry.HotelsListScreen.cellFontSize)
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, distanceLabel, availabilityLabel])
        stack.axis = .vertical
        stack.spacing = 4
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppGeometry.HotelsListScreen.cellSize),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppGeometry.HotelsListScreen.cellSize),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppGeometry.HotelsListScreen.cellSize),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -AppGeometry.HotelsListScreen.cellSize)
        ])
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray4.cgColor
        contentView.layer.cornerRadius = AppGeometry.HotelsListScreen.cellSize
    }
    
    func configure(with summary: HotelSummary) {
        nameLabel.text = summary.name
        if let dist = summary.distance {
            distanceLabel.text = String("Distance: \(dist) km")
        } else {
            distanceLabel.text = nil
        }
        if let suitesStr = summary.suitesAvailability,
           let count = Int(suitesStr) {
            availabilityLabel.text = "Available: \(count)"
        } else {
            availabilityLabel.text = nil
        }
    }
}
