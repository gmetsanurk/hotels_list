//
//  NetworkManager.swift
//  hotels_list
//
//  Created by Georgy on 2025-04-30.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case decodingError(String)
    case invalidImageData
}

final class NetworkManager: DataSource {
    private let jsonBaseURL = "https://raw.githubusercontent.com/iMofas/ios-android-test/master"
    private let imageBaseURL = "https://github.com/iMofas/ios-android-test/raw/master"
    
    private let urlSession = URLSession.shared
    
    private func fetchJSON<T: Codable>(from url: URL) async throws -> T {
        let (data, response) = try await urlSession.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
            throw NetworkError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error.localizedDescription)
        }
    }
    
    func fetchHotelList() async throws -> [HotelSummary] {
        guard let url = URL(string: "\(jsonBaseURL)/0777.json") else {
            throw NetworkError.invalidUrl
        }
        return try await fetchJSON(from: url)
    }
    
    func fetchHotelDetail(id: Int) async throws -> HotelDetail {
        guard let url = URL(string: "\(jsonBaseURL)/\(id).json") else {
            throw NetworkError.invalidUrl
        }
        return try await fetchJSON(from: url)
    }
    
    func fetchImageData(fileName: String) async throws -> Data {
        var components = URLComponents(string: imageBaseURL)
        components?.path = "/\(fileName)"
        
        guard let url = components?.url else {
            throw NetworkError.invalidUrl
        }
        
        let (data, response) = try await urlSession.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
            throw NetworkError.invalidResponse
        }
        return data
    }
}
