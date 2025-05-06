//
//  Hotels.swift
//  hotels_list
//
//  Created by Georgy on 2025-04-30.
//

import Foundation

class HotelSummary: Codable, Equatable {
    
    let id: UUID?
    let name: String?
    let address: String?
    let stars: Double?
    let distance: Double?
    let suitesAvailability: String?
    
    init(id: UUID, name: String, address: String, stars: Double?, distance: Double, suitesAvailability: String?) {
        self.id = id
        self.name = name
        self.address = address
        self.stars = stars
        self.distance = distance
        self.suitesAvailability = suitesAvailability
    }
    
    static func == (lhs: HotelSummary, rhs: HotelSummary) -> Bool {
        return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.address == rhs.address
        && lhs.stars == rhs.stars
        && lhs.distance == rhs.distance
        && lhs.suitesAvailability == rhs.suitesAvailability
    }
}
