//
//  Hotel.swift
//  hotels_list
//
//  Created by Georgy on 2025-04-30.
//
import Foundation

struct HotelDetail: Codable, Equatable, Sendable {
    let hotelSummary: HotelSummary
    let image: String?
    let latitude: Double
    let longitude: Double
}
