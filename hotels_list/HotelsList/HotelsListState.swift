//
//  HotelListState.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-06.
//
import Foundation
import ComposableArchitecture

@ObservableState
struct HotelsListState: Equatable {
  var listOfHotels: IdentifiedArrayOf<HotelDetailReducer.State> = .init()
  var isLoading: Bool = false
  var sortType: HotelSortType = .server
  var alertMessage: String?
}
