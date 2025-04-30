//
//  HotelReducer.swift
//  hotels_list
//
//  Created by Georgy on 2025-04-30.
//

import Foundation
import ComposableArchitecture

@Reducer
struct HotelReducer {
    @ObservableState
    struct State: Identifiable, Equatable {
        var id = UUID()
        var hotel: Hotel = .init(name: "")
    }
    
    enum Action {
        case some
    }

    var body: some Reducer<State, Action> {
        EmptyReducer()
    }
}
