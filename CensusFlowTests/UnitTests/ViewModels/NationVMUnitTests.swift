//
//  NationVMUnitTests.swift
//  CensusFlowTests
//
//  Created by David Lourenço on 11/10/2024.
//

import XCTest
@testable import CensusFlow

final class NationVMUnitTests: XCTestCase {

    
    var mockAPI: MockUSADataAPI<NationData>!
    var viewModel: NationViewModel<MockUSADataAPI<NationData>>!
    
    override func setUp() {
        super.setUp()
        mockAPI = MockUSADataAPI()
        viewModel = NationViewModel(USADataAPI: mockAPI)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPI = nil
        super.tearDown()
    }
    
    func testInitialState() {
        // Assert
        XCTAssertTrue(viewModel.nationList.isEmpty, "The nation list array should be empty.")
        XCTAssertTrue(viewModel.nationSearchBarText.isEmpty, "The nation search bar text should be empty.")
        XCTAssertFalse(viewModel.showInfoView, "The showInfoView should be false.")
        XCTAssertFalse(viewModel.isLoading, "The isLoading state for the nation screen should be false.")
        XCTAssertFalse(viewModel.showAlert, "The showAlert state for the nation screen should be false.")
    }

    func testFilteredNationListWhenSearchBarIsEmpty() {
        // Arrange
        let nation = Nation(idNation: "01000US", nation: "United States", idYear: 2022, year: "2022", population: 331097593, slugNation: "united-states")
        viewModel.nationList = [nation]
        viewModel.nationSearchBarText = ""
        
        // Act
        let filteredNations = viewModel.filteredNationList
        
        // Assert
        XCTAssertEqual(filteredNations.count, 1, "The filtered nations array should only have one element.")
        XCTAssertEqual(filteredNations.first?.nation, "United States", "The filter nations variable is not working as intended.")
    }

    func testFilteredNationListWithSearchTextForPopulation() {
        // Arrange
        let nation = Nation(idNation: "01000US", nation: "United States", idYear: 2022, year: "2022", population: 331097593, slugNation: "united-states")
        viewModel.nationList = [nation]
        viewModel.nationSearchBarText = "331097593"
        
        // Act
        let filteredNations = viewModel.filteredNationList
        
        // Assert
        XCTAssertEqual(filteredNations.count, 1, "The filtered nations array should only have one element.")
        XCTAssertEqual(filteredNations.first?.population, 331097593,
                       "The filter for nation population is not working as intended.")
    }
    
    func testFilteredNationListWithSearchTextForYear() {
        
        // Arrange
        let nation = Nation(idNation: "01000US", nation: "United States", idYear: 2022, year: "2022", population: 331097593, slugNation: "united-states")
        viewModel.nationList = [nation]
        viewModel.nationSearchBarText = "2022"
        
        // Act
        let filteredNations = viewModel.filteredNationList
        
        // Assert
        XCTAssertEqual(filteredNations.count, 1, "The filtered nations array should only have one element.")
        XCTAssertEqual(filteredNations.first?.year, "2022",
                       "The filter for the yearly population result is not working as intended.")
    }

    func testFetchNationSuccess() async {
        // Arrange
        let nationData = NationData(data: [Nation(idNation: "01000US", nation: "United States", idYear: 2022, year: "2022", population: 331097593, slugNation: "united-states")])
        
        mockAPI.mockData = nationData
        
        // Act
        _ = await viewModel.fetchNation()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading, "The isLoading state for the nation screen should be false.")
        XCTAssertEqual(viewModel.nationList.count, 1, "The nationList should only have 1 element.")
        XCTAssertEqual(viewModel.nationList.first?.nation, "United States", "The nation property should match.")
    }
    
    func testFetchNationFailure() async {
        // Arrange
        mockAPI.shouldReturnError = true

        
        // Act
        await viewModel.fetchNation()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading, "The isLoading state for the nation screen should be false.")
        XCTAssertTrue(viewModel.showAlert, "The showAlert state for the nation screen should be true.")
        XCTAssertTrue(viewModel.nationList.isEmpty, "The nationList should be empty.")
    }

    func testFetchNationEmptyData() async {
        // Arrange
        let emptyNationData = NationData(data: [])
        mockAPI.mockData = emptyNationData
        
        // Act
        await viewModel.fetchNation()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading, "The isLoading state for the nation screen should be false.")
        XCTAssertEqual(viewModel.nationList.count, 0, "The nationList should have 0 elements.")
        XCTAssertTrue(viewModel.showAlert, "The showAlert state for the nation screen should be true.")
    }

    func testFetchNationLoadingState() async {
        // Arrange
        let expectation = XCTestExpectation(description: "Loading state is set correctly")
        mockAPI.mockData = NationData(data: [])
        
        // Act
        let loadingTask = Task {
            await viewModel.fetchNation()
            XCTAssertFalse(viewModel.isLoading, "The isLoading state for the nation screen should be false.")
            expectation.fulfill()
        }

        // Set loading state
        _ = await viewModel.triggerLoading()
        XCTAssertTrue(viewModel.isLoading, "The isLoading state for the nation screen should be true.")

        await loadingTask.value // Wait for the async task to complete
        await fulfillment(of: [expectation], timeout: 1)
    }
}
