//
//  MockUSADataAPI.swift
//  CensusFlowTests
//
//  Created by David Lourenço on 11/10/2024.
//

import Foundation
@testable import CensusFlow

class MockUSADataAPI<T: Decodable>: USADataProtocol {

    // Mock data
    var mockData: T?
    
    // Mock error
    var mockError: Error?
    var shouldReturnError : Bool = false
    
    
    func fetchNationPopulationData() async throws -> T {
        if shouldReturnError{
            if let error = mockError{
                throw error
            } else {
                throw Errors.unknownError(NSError(domain: "Unknown Error", code: -1, userInfo: nil))
            }
        }
        
        guard let data = mockData else{
            throw Errors.unknownError(NSError(domain: "No mock data", code: -1, userInfo: nil))
        }
        
        return data
    }
    
}
