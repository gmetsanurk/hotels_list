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
    case start
    case hotelsLoaded([HotelSummary])
    case hotelSelected(HotelSummary)
    //case imageReceived(UIImage, HotelDetail)
}
