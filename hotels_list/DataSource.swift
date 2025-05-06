//
//  DataSource.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-06.
//

protocol DataSource: Sendable {
    func fetchHotelsList() async throws -> [HotelSummary]
    func fetchHotelDetail(id: Int) async throws -> HotelDetail
    func fetchImageData(fileName: String) async throws -> Data
}

protocol LocalDataSource: DataSource {
    func save()
}

struct SomeLocal: LocalDataSource {
    func fetchHotelsList() async throws -> [HotelSummary] {
        [.init(id: .init(), name: "some name", address: "", stars: nil, distance: 0, suitesAvailability: "")]
    }
    
    func fetchHotelDetail(id: Int) async throws -> HotelDetail {
        .init(hotelSummary: .init(id: .init(), name: "", address: "", stars: nil, distance: 0, suitesAvailability: ""), image: nil, latitude: 0, longitude: 0)
    }
    
    func fetchImageData(fileName: String) async throws -> Data {
        .init()
    }
    
    func save() {
        
    }
}
