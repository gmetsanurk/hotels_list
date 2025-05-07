//
//  DataSourceDependency.swift
//  hotels_list
//
//  Created by Georgy on 2025-05-07.
//

import ComposableArchitecture

extension DependencyValues {
    var dataSource: any DataSource {
        get { self[DataSourceKey.self] }
        set { self[DataSourceKey.self] = newValue }
    }
    
    private enum DataSourceKey: DependencyKey {
        static let liveValue: any DataSource = iMofasNetworkManager()
    }
}
