//
//  RealmLocalDataSource.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-07.
//
import RealmSwift

actor RealmLocalDataSource: LocalDataSource, Sendable {
    private let realm: Realm
    
    init(configuration: Realm.Configuration = .defaultConfiguration) throws {
        self.realm = try Realm(configuration: configuration)
    }
    
    func fetchCachedHotels() async throws -> [HotelSummary] {
        let objects = realm.objects(HotelSummaryRealmObject.self)
        return objects.map { $0.toModel() }
    }
    
    func saveHotels(_ hotels: [HotelSummary]) async throws {
        let objects = hotels.map { HotelSummaryRealmObject(summary: $0) }
        try realm.write {
            realm.add(objects, update: .modified)
        }
    }
}
