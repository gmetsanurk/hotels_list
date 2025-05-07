//
//  Hotels.swift
//  hotels_list
//
//  Created by Georgy on 2025-04-30.
//

import Foundation

struct HotelSummary: Identifiable, Codable, Equatable, Sendable {
    let id: Int
    let name: String?
    let address: String?
    let stars: Double?
    let distance: Double?
    let suitesAvailability: String?
}
