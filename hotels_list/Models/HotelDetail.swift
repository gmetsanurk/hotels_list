//
//  Hotel.swift
//  hotels_list
//
//  Created by Georgy on 2025-04-30.
//

import Foundation

struct HotelDetail: Codable, Equatable, Sendable {
    let id: Int
    let name: String?
    let address: String?
    let stars: Double?
    let distance: Double?
    let suitesAvailability: String?
    let image: String?
    let lat: Double
    let lon: Double
    
    var hotelSummary: HotelSummary {
        HotelSummary(
            id: id,
            name: name,
            address: address,
            stars: stars,
            distance: distance,
            suitesAvailability: suitesAvailability
        )
    }
}
