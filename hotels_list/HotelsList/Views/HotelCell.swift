//
//  HotelSummaryCell.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-06.
//

import UIKit

let magicNumber: CGFloat = 8
let magicFontSize: CGFloat = 14

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
        distanceLabel.font = .systemFont(ofSize: magicFontSize)
        availabilityLabel.font = .systemFont(ofSize: magicFontSize)
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, distanceLabel, availabilityLabel])
        stack.axis = .vertical
        stack.spacing = 4
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: magicNumber),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: magicNumber),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -magicNumber),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -magicNumber)
        ])
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray4.cgColor
        contentView.layer.cornerRadius = magicNumber
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
