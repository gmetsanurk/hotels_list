//
//  HotelDetailState.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-07.
//

import UIKit

struct HotelDetailState: Equatable {
    var summary: HotelSummary
    var detail: HotelDetail?
    var image: UIImage?
    var isLoading = false
}
