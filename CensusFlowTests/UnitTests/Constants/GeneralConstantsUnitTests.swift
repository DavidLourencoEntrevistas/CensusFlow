//
//  GeneralConstantsUnitTests.swift
//  CensusFlowTests
//
//  Created by David Lourenço on 12/10/2024.
//

import XCTest

@testable import CensusFlow

final class GeneralConstantsUnitTests: XCTestCase {

    func testGeneralConstantsValues(){
        
        // Arrange
        let expectedValues = [
            "📃 CensusFlow",
            "Description",
            "This app provides insights into the population of the USA by year.",
            "Features:",
            "View the population of the USA by year.",
            "Explore state-by-state population data.",
            "Search for specific years or states.",
            "How to Use:",
            "1. Navigate between tabs to access national and state population data.",
            "2. Use the search function to find specific data.",
            "xmark",
            "🤔",
            "Something went wrong, try again later.",
            "AppIconImage"
        ]
        
        // Act
        let actualValues = [
            GeneralConstants.title,
            GeneralConstants.descriptionTitle,
            GeneralConstants.description,
            GeneralConstants.featuresTitle,
            GeneralConstants.featuresOne,
            GeneralConstants.featuresTwo,
            GeneralConstants.featuresThree,
            GeneralConstants.howToUseTitle,
            GeneralConstants.howToUseOne,
            GeneralConstants.howToUseTwo,
            GeneralConstants.closeIcon,
            GeneralConstants.errorEmoji,
            GeneralConstants.errorScreenText,
            GeneralConstants.appIcon
        ]
    
        
        // Assert
        for (index, expectedValue) in expectedValues.enumerated(){
            XCTAssertEqual(actualValues[index], expectedValue, "The general constant value at index \(index) should be \(expectedValue).")
        }
        
    }
    
    func testInfoSheetDictStructure() {
        // Arrange
        let expectedKeys = [
            GeneralConstants.descriptionTitle,
            GeneralConstants.featuresTitle,
            GeneralConstants.howToUseTitle
        ]
        
        // Act
        let actualKeys = Array(GeneralConstants.infoSheetDict.keys)

        // Assert
        XCTAssertEqual(Set(actualKeys), Set(expectedKeys), "The keys in infoSheetDict should match the expected keys.")
    }

    func testInfoSheetDictValues() {
        // Arrange
        let expectedValues: [String: [String]] = [GeneralConstants.descriptionTitle: [GeneralConstants.description], GeneralConstants.featuresTitle: [GeneralConstants.featuresOne, GeneralConstants.featuresTwo, GeneralConstants.featuresThree], GeneralConstants.howToUseTitle: [GeneralConstants.howToUseOne, GeneralConstants.howToUseTwo]]

        // Act
        let actualValues = GeneralConstants.infoSheetDict

        // Assert
        for (key, expectedValue) in expectedValues {
            XCTAssertEqual(actualValues[key], expectedValue, "The values for key \(key) do not match the expected values.")
        }
    }

}
