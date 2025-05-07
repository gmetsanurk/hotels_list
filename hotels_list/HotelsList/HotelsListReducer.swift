//
//  HotelsReducer.swift
//  hotels_list
//
//  Created by Georgy on 2025-04-30.
//

import ComposableArchitecture

@Reducer
struct HotelsListReducer {
    @Dependency(\.dataSource) var dataSource
    @Dependency(\.localStorage) var localStorage
    
    var coordinator: Coordinator?
    
    var body: some Reducer<HotelsListState, HotelsListAction> {
        Reduce { state, action in
            switch action {
            case .start:
                return .run { send in
                    if let cached = try? await localStorage.fetchCachedHotels() {
                        await send(.hotelsLoaded(cached))
                    }
                    
                    do {
                        let freshHotels = try await dataSource.fetchHotelsList()
                        await send(.hotelsLoaded(freshHotels))
                        try await localStorage.saveHotels(freshHotels)
                    }
                }
            case .hotelsLoaded(let listOfHotels):
                state.listOfHotels = IdentifiedArrayOf<HotelDetailReducer.State>(uniqueElements: listOfHotels.map {
                    .init(id: $0.id, summary: $0)
                })
                return .none
            case .hotelSelected(let hotelSummary):
                Task { @MainActor in
                    coordinator?.openHotelDetail(hotelSummary)
                }
                return .none
            }
        }
    }
}
