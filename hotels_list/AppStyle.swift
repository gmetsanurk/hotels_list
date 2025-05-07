//
//  AppStyle.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-07.
//

import UIKit

struct Colors {
    static let backgroundColor = UIColor.systemBackground
}

struct AppGeometry {
  struct HotelsListScreen {
    static let horizontalPadding: CGFloat = 16
    static let verticalPadding: CGFloat = 16
    static let cellSize: CGFloat = 10
    static let cellFontSize: CGFloat = 14
  }

  struct HotelDetailScreen {
    static let imageHeight: CGFloat = 200
    static let horizontalPadding: CGFloat = 16
    static let verticalSpacing: CGFloat = 8
    static let coordinateTopSpacing: CGFloat = 4
    static let topImagePadding: CGFloat = 0
  }
}
