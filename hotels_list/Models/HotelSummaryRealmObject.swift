//
//  HotelSummaryRealmObject.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-07.
//

import RealmSwift

class HotelSummaryRealmObject: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String?
    @Persisted var address: String?
    @Persisted var stars: Double?
    @Persisted var distance: Double?
    @Persisted var suitesAvailability: String?
    
    convenience init(summary: HotelSummary) {
        self.init()
        self.id = summary.id
        self.name = summary.name
        self.address = summary.address
        self.stars = summary.stars ?? 0.0
        self.distance = summary.distance ?? 0.0
        self.suitesAvailability = summary.suitesAvailability
    }
}

extension HotelSummaryRealmObject {
    func toModel() -> HotelSummary {
        HotelSummary(
            id: id,
            name: name,
            address: address,
            stars: stars,
            distance: distance,
            suitesAvailability: suitesAvailability
        )
    }
}
