//
//  HotelReducer.swift
//  hotels_list
//
//  Created by Georgy on 2025-04-30.
//

import UIKit
import ComposableArchitecture

enum HotelDetailError: Error {
    case error
}

@Reducer
struct HotelDetailReducer {
    @Dependency(\.dataSource) var dataSource
    
    @ObservableState
    struct State: Equatable, Identifiable {
            let id: Int
            var summary: HotelSummary
            var hotel: HotelDetail
            var image: UIImage?
            var isLoading = false

        init(summary: HotelSummary) {
            self.id = summary.id
            self.summary = summary
            
            self.hotel = HotelDetail(
                hotelSummary: summary,
                image: nil,
                latitude: 0,
                longitude: 0
            )
        }
        
        /*init(
         id: Int = .init(),
         summary: HotelSummary = .init(id: 0, name: "", address: "", stars: 0.0, distance: 0.0, suitesAvailability: ""),
         hotel: HotelDetail? = nil
         ) {
         self.id = id
         // если hotel не передали — создаём его на основе готового summary
         self.hotel = hotel ?? .init(hotelSummary: summary, image: "", latitude: 0.0, longitude: 0.0)
         }*/
        
    }
    enum Action: Equatable {
        case onAppear
        case detailLoaded(HotelDetail)
        case imageLoaded(UIImage)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                let hotelId = state.id
                return .run { send in
                    let detail = try await dataSource.fetchHotelDetail(id: hotelId)
                    await send(.detailLoaded(detail))
                }
            case .detailLoaded(let hotel):
                state.hotel = hotel
                guard let fileName = hotel.image else {
                    return .none
                }
                return .run { send in
                    let uiImage = try await loadImage(fileName: fileName)
                    await send(.imageLoaded(uiImage))
                }
                
            case .imageLoaded(let uiImage):
                state.image = uiImage
                state.isLoading = false
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
