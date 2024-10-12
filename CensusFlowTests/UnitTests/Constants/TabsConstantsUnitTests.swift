//
//  TabsConstantsUnitTests.swift
//  CensusFlowTests
//
//  Created by David Lourenço on 11/10/2024.
//

import XCTest
@testable import CensusFlow

final class TabsConstantsUnitTests: XCTestCase {

    func testTabsConstantsValues(){
        
        // Arrange
        let expectedValues = [
            "flag.fill",
            "house.and.flag.fill",
            "USA Nation",
            "States"
        ]
        
        // Act
        let actualValues = [
            TabsConstants.nationIcon,
            TabsConstants.statesIcon,
            TabsConstants.nationText,
            TabsConstants.statesText
        ]
        
        // Assert
        for (index, expectedValue) in expectedValues.enumerated(){
            XCTAssertEqual(actualValues[index], expectedValue, "The tabs constant value at index \(index) should be \(expectedValue).")
        }

    }

}
