//
//  StatesConstantsUnitTests.swift
//  CensusFlowTests
//
//  Created by David Lourenço on 11/10/2024.
//

import XCTest
@testable import CensusFlow

final class StatesConstantsUnitTests: XCTestCase {

    func testStatesConstantsValues(){
        
        // Arrange
        let expectedValues = [
            "🇺🇸 States",
            "https://datausa.io/api/data?drilldowns=State&measures=Population&year=latest",
            "info.circle"
        ]
        
        // Act
        let actualValues = [
            StatesConstants.navigationTitle,
            StatesConstants.statesURL,
            StatesConstants.statesInfoIcon
        
        ]
        
        // Assert
        for (index, expectedValue) in expectedValues.enumerated(){
            XCTAssertEqual(actualValues[index], expectedValue, "The states constant value at index \(index) should be \(expectedValue).")
        }
        
    }
    
}
