//
//  NationConstantsUnitTests.swift
//  CensusFlowTests
//
//  Created by David Lourenço on 11/10/2024.
//

import XCTest
@testable import CensusFlow

final class NationConstantsUnitTests: XCTestCase {

    func testNationConstantsValues(){
        
        // Arrange
        let expectedValues = [
            "🇺🇸 USA Nation",
            "https://datausa.io/api/data?drilldowns=Nation&measures=Population"
        ]
        
        // Act
        let actualValues = [
            NationConstants.navigationTitle,
            NationConstants.nationURL
        ]
        
        // Assert
        for (index, expectedValue) in expectedValues.enumerated() {
            XCTAssertEqual(actualValues[index], expectedValue, "The nation constant value at index \(index) should be \(expectedValue).")
        }
    
    }
}
