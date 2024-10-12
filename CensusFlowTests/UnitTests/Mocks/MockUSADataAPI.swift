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
    var shouldReturnError : Bool = false
    
    
    func fetchData() async throws -> T {
        if shouldReturnError{
            throw Errors.unknownError
        }
        
        guard let data = mockData else{
            throw Errors.unknownError
        }
        
        return data
    }
    
}
