//
//  HotelDetailAction.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-06.
//
import Foundation

enum HotelDetailAction {
  case onAppear
  case detailResponse(Result<HotelDetail, NetworkError>)
  case imageResponse(Result<Data, NetworkError>)
  case dismissAlert
}
