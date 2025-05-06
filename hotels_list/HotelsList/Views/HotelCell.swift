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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.numberOfLines = 2
        distanceLabel.font = .systemFont(ofSize: 14)
        availabilityLabel.font = .systemFont(ofSize: 14)
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, distanceLabel, availabilityLabel])
        stack.axis = .vertical
        stack.spacing = 4
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray4.cgColor
        contentView.layer.cornerRadius = 8
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
