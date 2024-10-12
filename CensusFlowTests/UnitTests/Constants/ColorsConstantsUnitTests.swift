//
//  ColorsConstantsUnitTests.swift
//  CensusFlowTests
//
//  Created by David Lourenço on 11/10/2024.
//

import XCTest
import SwiftUI

@testable import CensusFlow

final class ColorsConstantsUnitTests: XCTestCase {

    func testColorsConstantsValues(){
        
        // Arrange
        let expectedColor = Color(.systemRed)
        
        // Act
        let isColorEqual = Colors.accentIconColor == expectedColor
        
        // Assert
        XCTAssertTrue(isColorEqual, "The color value should be valid.")
        
    }

}
