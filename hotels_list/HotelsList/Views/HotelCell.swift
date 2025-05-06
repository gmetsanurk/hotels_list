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
