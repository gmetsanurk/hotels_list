//
//  LocalDataSourceDependency.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-07.
//
import ComposableArchitecture

extension DependencyValues {
    var localStorage: any LocalDataSource {
        get { self[LocalDataSourceKey.self] }
        set { self[LocalDataSourceKey.self] = newValue }
    }
    
    private enum LocalDataSourceKey: DependencyKey {
        static let liveValue: any LocalDataSource = SomeLocal()
    }
}
