//
//  APIService.swift
//  KlarnaTest
//
//  Created by Taranjeet Kaur on 21/07/23.
//

import Foundation

protocol APIServiceProtocol {

    func getJSON<T: Decodable>(urlString: String) async throws -> T

}

struct APIService : APIServiceProtocol {
   
    func getJSON<T: Decodable>(urlString: String) async throws -> T {
        guard
            let url = URL(string: urlString)
        else {
            throw APIError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                throw APIError.invalidResponseStatus
            }
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw APIError.decodingError(error.localizedDescription)
            }
        } catch {
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }

}
