//
//  HotelsListAction.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-06.
//
import Foundation
import ComposableArchitecture
import UIKit

enum HotelsListAction {
    
  /*case onAppear
  case hotelsResponse(Result<[HotelSummary], NetworkError>)
  case sortChanged(HotelSortType)
  case hotelTapped(HotelSummary)
  case dismissAlert*/
    
    case start
    case hotelsLoaded([HotelSummary])
    case hotelSelected(Hotel)
    case imageReceived(UIImage, Hotel)
}
