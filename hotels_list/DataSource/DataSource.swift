//
//  DataSource.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-06.
//

import UIKit

protocol DataSource: Sendable {
    func fetchHotelsList() async throws -> [HotelSummary]
    func fetchHotelDetail(id: Int) async throws -> HotelDetail
    func fetchImageData(fileName: String) async throws -> Data
}

protocol LocalDataSource: Sendable {
    func fetchCachedHotels() async throws -> [HotelSummary]
    func saveHotels(_ hotels: [HotelSummary]) async throws
}

struct SomeLocal: DataSource, LocalDataSource {
    func fetchHotelsList() async throws -> [HotelSummary] {
        [.init(id: .init(), name: "some name", address: "", stars: nil, distance: 0, suitesAvailability: "")]
    }
    
    func fetchHotelDetail(id: Int) async throws -> HotelDetail {
        .init(id: 0, name: "", address: "", stars: 0, distance: 0, suitesAvailability: "", image: "", lat: 0, lon: 0)
    }
    
    func fetchImageData(fileName: String) async throws -> Data {
        .init()
    }
    
    func fetchCachedHotels() throws -> [HotelSummary] {
        .init()
    }
    
    func saveHotels(_ hotels: [HotelSummary]) throws {

    }
}
