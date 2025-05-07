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
        var alertMessage: String?
        
        init(summary: HotelSummary) {
            self.id = summary.id
            self.summary = summary
            
            self.hotel = HotelDetail(
                id: summary.id,
                name: summary.name,
                address: summary.address,
                stars: summary.stars,
                distance: summary.distance,
                suitesAvailability: summary.suitesAvailability,
                image: nil,
                lat: 0,
                lon: 0
            )
        }
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
                    do {
                        let detail = try await dataSource.fetchHotelDetail(id: hotelId)
                        await send(.detailLoaded(detail))
                    } catch {
                        print("Detail could not be loaded")
                    }
                }
            case .detailLoaded(let hotel):
                state.hotel = hotel
                
                let placeholderImage = UIImage(named: "placeholder")
                ?? UIImage(systemName: "photo")
                ?? UIImage()
                
                guard let fileName = hotel.image, !fileName.isEmpty else {
                    state.image = placeholderImage
                    state.isLoading = false
                    return .none
                }
                
                state.isLoading = true
                return .run { send in
                    do {
                        let uiImage = try await loadImage(fileName)
                        await send(.imageLoaded(uiImage))
                    } catch {
                        await send(.imageLoaded(placeholderImage))
                    }
                }
                
            case .imageLoaded(let uiImage):
                state.image = uiImage
                state.isLoading = false
                return .none
            }
        }
    }
    
    private func loadImage(_ fileName: String) async throws -> UIImage {
        let data = try await dataSource.fetchImageData(fileName: fileName)
        guard let image = UIImage(data: data) else {
            throw NetworkError.invalidImageData
        }
        return image
    }
}
