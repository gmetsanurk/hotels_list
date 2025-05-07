//
//  RealmLocalDataSource.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-07.
//
import RealmSwift

actor RealmLocalDataSource: LocalDataSource, Sendable {
    func fetchCachedHotels() throws -> [HotelSummary] {
        let realm = try Realm()
        let objects = realm.objects(HotelSummaryRealmObject.self)
        return objects.map { $0.toModel() }
    }

    func saveHotels(_ hotels: [HotelSummary]) throws {
        let realm = try Realm()
        let objects = hotels.map(HotelSummaryRealmObject.init(summary:))
        try realm.write {
            realm.add(objects, update: .modified)
        }
    }
}
