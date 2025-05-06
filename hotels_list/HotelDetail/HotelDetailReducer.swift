//
//  HotelReducer.swift
//  hotels_list
//
//  Created by Georgy on 2025-04-30.
//

import Foundation
import ComposableArchitecture

@Reducer
struct HotelDetailReducer {
    @ObservableState
    struct State: Identifiable, Equatable {
        var id = UUID()
        var summary: HotelSummary
        var hotel: Hotel
        
        init(
            id: UUID = .init(),
            summary: HotelSummary = .init(id: UUID(0), name: "", address: "", stars: 0.0, distance: 0.0, suitesAvailability: [0]),
            hotel: Hotel? = nil
          ) {
            self.id = id
            self.summary = summary
            // если hotel не передали — создаём его на основе готового summary
            self.hotel = hotel ?? .init(hotelSummary: summary, image: "", latitude: 0.0, longitude: 0.0)
          }

    }
    
    enum Action {
        case some
    }

    var body: some Reducer<State, Action> {
        EmptyReducer()
    }
}
