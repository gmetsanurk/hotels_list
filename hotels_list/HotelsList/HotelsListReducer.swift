//
//  HotelsReducer.swift
//  hotels_list
//
//  Created by Georgy on 2025-04-30.
//

import UIKit
import ComposableArchitecture

typealias Hotel = HotelDetail
let imageName = "N"

@Reducer
struct HotelsListReducer {
    @Dependency(\.dataSource) var dataSource
    @Dependency(\.localStorage) var localStorage
    
    var body: some Reducer<HotelsListState, HotelsListAction> {
        Reduce { state, action in
            switch action {
            case .start:
                return .run { send in
                    let hotels = try await dataSource.fetchHotelsList()
                    await send(.hotelsLoaded(hotels))
                }
            case .hotelsLoaded(let hotels):
                state.hotels = IdentifiedArrayOf<HotelDetailReducer.State>(uniqueElements: hotels.map {
                    .init(id: $0.id ?? .init(), summary: $0)
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
    
    private func loadImage(fileName: String) async throws -> UIImage {
        let data = try await dataSource.fetchImageData(fileName: fileName)
        guard let image = UIImage(data: data) else {
            throw NetworkError.invalidImageData
        }
        return image
    }
}
