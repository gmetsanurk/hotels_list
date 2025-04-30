//
//  Hotel.swift
//  hotels_list
//
//  Created by Georgy on 2025-04-30.
//
import Foundation

struct HotelDetail: Equatable {
    
    let hotelSummary: HotelSummary
    let image: String?
    let latitude: Decimal
    let longitude: Decimal
    
    static func == (lhs: HotelDetail, rhs: HotelDetail) -> Bool {
        return lhs.hotelSummary == rhs.hotelSummary
            && lhs.image == rhs.image
            && lhs.latitude == rhs.latitude
            && lhs.longitude == rhs.longitude
    }
}
