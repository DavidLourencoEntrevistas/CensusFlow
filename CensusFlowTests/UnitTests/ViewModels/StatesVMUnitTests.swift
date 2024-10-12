//
//  StatesVMUnitTests.swift
//  CensusFlowTests
//
//  Created by David Lourenço on 11/10/2024.
//

import XCTest
@testable import CensusFlow

final class StatesVMUnitTests: XCTestCase {

    
    var mockAPI: MockUSADataAPI<StateData>!
    var viewModel: StatesViewModel<MockUSADataAPI<StateData>>!
    
    override func setUp() {
        super.setUp()
        mockAPI = MockUSADataAPI()
        viewModel = StatesViewModel(USADataAPI: mockAPI)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPI = nil
        super.tearDown()
    }
    
    func testInitialState() {
        // Assert
        XCTAssertTrue(viewModel.states.isEmpty, "The states list array should be empty.")
        XCTAssertTrue(viewModel.statesSearchBarText.isEmpty, "The states search bar text should be empty.")
        XCTAssertFalse(viewModel.showInfoView, "The showInfoView should be false.")
        XCTAssertFalse(viewModel.isLoading, "The isLoading for the states screen should be false.")
        XCTAssertFalse(viewModel.showAlert, "The showAlert for the states screen should be false.")
    }

    func testFilteredStateListWhenSearchBarIsEmpty() {
        // Arrange
        let state = StateModel(idState: "04000US01", state: "Alabama", idYear: 2022, year: "2022", population: 5028092, slugState: "alabama")
        viewModel.states = [state]
        viewModel.statesSearchBarText = ""

        // Act
        let filteredStates = viewModel.filteredStateList

        // Assert
        XCTAssertEqual(filteredStates.count, 1, "The filtered states array should only have one element.")
        XCTAssertEqual(filteredStates.first?.state, "Alabama", "The filter states variable is not working as intended.")
    }

    func testFilteredStateListWithSearchTextForPopulation() {
        // Arrange
        let state = StateModel(idState: "04000US01", state: "Alabama", idYear: 2022, year: "2022", population: 5028092, slugState: "alabama")
        viewModel.states = [state]
        viewModel.statesSearchBarText = "5028092"

        // Act
        let filteredStates = viewModel.filteredStateList

        // Assert
        XCTAssertEqual(filteredStates.count, 1, "The filtered states array should only have one element.")
        XCTAssertEqual(filteredStates.first?.population, 5028092, "The filter for state population is not working as intended.")
    }

    func testFilteredStateListWithSearchTextForState() {
        // Arrange
        let state = StateModel(idState: "04000US01", state: "Alabama", idYear: 2022, year: "2022", population: 5028092, slugState: "alabama")
        viewModel.states = [state]
        viewModel.statesSearchBarText = "Alabama"

        // Act
        let filteredStates = viewModel.filteredStateList

        // Assert
        XCTAssertEqual(filteredStates.count, 1, "The filtered states array should only have one element.")
        XCTAssertEqual(filteredStates.first?.state, "Alabama", "The filter for the state name is not working as intended.")
    }

    func testFetchStateSuccess() async {
        
        // Arrange
        let stateData = StateData(data: [StateModel(idState: "04000US01", state: "Alabama", idYear: 2022, year: "2022", population: 5028092, slugState: "alabama")])
        
        mockAPI.mockData = stateData
        
        // Act
        _ = await viewModel.fetchState()
    
        // Assert
        XCTAssertFalse(viewModel.isLoading, "The isLoading state for the state screen should be false.")
        XCTAssertEqual(viewModel.states.count, 1, "The stateList should only have 1 element.")
        XCTAssertEqual(viewModel.states.first?.state, "Alabama", "The state property should match.")
    }

    func testFetchStateFailure() async {
        // Arrange
        mockAPI.shouldReturnError = true

        // Act
        await viewModel.fetchState()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading, "The isLoading state for the state screen should be false.")
        XCTAssertTrue(viewModel.showAlert, "The showAlert state for the state screen should be true.")
        XCTAssertTrue(viewModel.states.isEmpty, "The stateList should be empty.")
    }

    func testFetchStateEmptyData() async {
        // Arrange
        let emptyStateData = StateData(data: [])
        mockAPI.mockData = emptyStateData
        
        // Act
        await viewModel.fetchState()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading, "The isLoading state for the state screen should be false.")
        XCTAssertEqual(viewModel.states.count, 0, "The stateList should have 0 elements.")
        XCTAssertTrue(viewModel.showAlert, "The showAlert state for the state screen should be true.")
    }

    func testFetchStateLoadingState() async {
        // Arrange
        let expectation = XCTestExpectation(description: "Loading state is set correctly")
        mockAPI.mockData = StateData(data: [])
        
        // Act
        let loadingTask = Task {
            await viewModel.fetchState()
            XCTAssertFalse(viewModel.isLoading, "The isLoading state for the state screen should be false.")
            expectation.fulfill()
        }

        // Set loading state
        _ = await viewModel.triggerLoading()
        XCTAssertTrue(viewModel.isLoading, "The isLoading state for the state screen should be true.")

        await loadingTask.value // Wait for the async task to complete
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    func testRefreshStateData() async {
        // Arrange
        let initialStateData = StateData(data: [StateModel(idState: "04000US01", state: "Alabama", idYear: 2022, year: "2022", population: 5028092, slugState: "alabama")])
        
        mockAPI.mockData = initialStateData
        
        await viewModel.fetchState()
        
        // Act
        let newStateData = StateData(data: [StateModel(idState: "04000US02", state: "Alaska", idYear: 2022, year: "2022", population: 734821, slugState: "alaska")])
        
        mockAPI.mockData = newStateData
        
        await viewModel.fetchState()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading, "The isLoading state for the states screen should be false after refresh.")
        XCTAssertEqual(viewModel.states.count, 1, "The states should only have 1 element after refresh.")
        XCTAssertEqual(viewModel.states.first?.population, 734821, "The population property should match the newly fetched data.")
        XCTAssertEqual(viewModel.states.first?.state, "Alaska", "The state property should match the newly fetched data.")
    }
}
