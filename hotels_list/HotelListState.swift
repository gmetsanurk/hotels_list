//
//  HotelListState.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-06.
//
import Foundation
import ComposableArchitecture

struct HotelsListState {
  var hotels: [HotelSummary] = []
  var isLoading: Bool = false
  var sortType: HotelSortType = .server
  var alertMessage: String?
}

extension HotelsListState: Equatable {
    static func == (lhs: HotelsListState, rhs: HotelsListState) -> Bool {
        lhs.hotels == rhs.hotels
         && lhs.isLoading == rhs.isLoading
         && lhs.sortType == rhs.sortType
         && lhs.alertMessage == rhs.alertMessage
    }
}
