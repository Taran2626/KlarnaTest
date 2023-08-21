//
//  MockAPIService.swift
//  KlarnaTestTests
//
//  Created by Taranjeet Kaur on 22/08/23.
//

import Foundation
@testable import KlarnaTest

struct MockAPIService : APIServiceProtocol {
    
    var isSuccess = true
    
    init(isSuccess : Bool = true){
        self.isSuccess = isSuccess
    }
    
    func getJSON<T>(urlString: String) async throws -> T where T : Decodable {
        let decodedData = Bundle.main.decode(T.self, from: urlString.contains("/weather") ? "Current.json" : "Forecast.json")
        if isSuccess {
            return decodedData
        } else {
            throw APIError.corruptData
        }
    }
    
}
