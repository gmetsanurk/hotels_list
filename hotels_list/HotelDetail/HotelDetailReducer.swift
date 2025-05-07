//
//  HotelReducer.swift
//  hotels_list
//
//  Created by Georgy on 2025-04-30.
//

import UIKit
import ComposableArchitecture

typealias Hotel = HotelDetail

@Reducer
struct HotelDetailReducer {
    @Dependency(\.dataSource) var dataSource
    @Dependency(\.mainRunLoop) var mainRunLoop
        
    
    @ObservableState
    struct State: Identifiable, Equatable {
        var id: Int
        var hotel: Hotel
        
        init(
            id: Int = .init(),
            summary: HotelSummary = .init(id: 0, name: "", address: "", stars: 0.0, distance: 0.0, suitesAvailability: ""),
            hotel: Hotel? = nil
          ) {
            self.id = id
            // если hotel не передали — создаём его на основе готового summary
            self.hotel = hotel ?? .init(hotelSummary: summary, image: "", latitude: 0.0, longitude: 0.0)
          }

    }
    

    var body: some Reducer<State, HotelDetailAction> {
        EmptyReducer()
    }
    
    private func loadImage(fileName: String) async throws -> UIImage {
        let data = try await dataSource.fetchImageData(fileName: fileName)
        guard let image = UIImage(data: data) else {
            throw NetworkError.invalidImageData
        }
        return image
    }
}
