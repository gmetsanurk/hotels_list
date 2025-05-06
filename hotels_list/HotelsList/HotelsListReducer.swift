//
//  HotelsReducer.swift
//  hotels_list
//
//  Created by Georgy on 2025-04-30.
//

import UIKit
import ComposableArchitecture

typealias Hotel = HotelDetail
var imageName = "N"

@Reducer
struct HotelsListReducer {
    @ObservableState
    struct State {
        var hotels: IdentifiedArrayOf<HotelDetailReducer.State> = .init()
    }
    
    enum Action {
        case start
        case hotelsLoaded([Hotel])
        case hotelSelected(Hotel)
        case imageReceived(UIImage, Hotel)
    }
    
    @Dependency(\.dataSource) var dataSource
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .start:
                return .run { send in
                    let hotels = try await dataSource.fetchHotels()
                    await send(.hotelsLoaded(hotels))
                }
            case .hotelsLoaded(let hotels):
                state.hotels = IdentifiedArrayOf<HotelDetailReducer.State>(uniqueElements: hotels.map {
                    .init(hotel: $0)
                })
                return .none
            case .hotelSelected(let hotel):
                return .run { send in
                    let image = try await loadImage(fileName: imageName)
                    await send(.imageReceived(image, hotel))
                }
            case .imageReceived(let image, let hotel):
                coordinator.open(hotel: hotel)
                return .none
            }
        }
    }
}
