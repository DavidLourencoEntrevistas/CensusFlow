//
//  USADataNationAPIUnitTests.swift
//  CensusFlowTests
//
//  Created by David Lourenço on 11/10/2024.
//

import XCTest
@testable import CensusFlow

final class USADataNationAPIUnitTests: XCTestCase {
    
    var session: URLSession!
    var urlString: String!
    var sut: USADataAPI<NationData>!

    override func setUp() {
        super.setUp()
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: configuration)
        
        urlString = "https://datausa.io/api/data?drilldowns=Nation&measures=Population"
        sut = USADataAPI<NationData>(urlString: urlString, session: session)
    }

    override func tearDown() {
        session = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
        MockURLProtocol.statusCode = 200
        MockURLProtocol.stubResponse = nil
        sut = nil
        urlString = nil
        super.tearDown()
    }
    
    func testFetchNationPopulationData_withInvalidUrl_throwsInvalidUrlError() async throws {
        // Arrange
        sut = USADataAPI<NationData>(urlString: "invalid-url", session: session)
        
        // Act & Assert
        do {
            _ = try await sut.fetchData()
            XCTFail("Expected to throw invalidUrl error, but succeeded")
        } catch let error as Errors {
            XCTAssertEqual(error, .invalidUrl)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testFetchNationPopulationData_withInvalidResponse_throwsInvalidResponseError() async throws {
        // Arrange
        sut = USADataAPI<NationData>(urlString: urlString, session: session)
        guard let url = URL(string: urlString) else {
            XCTFail("The URL should be valid.")
            return
        }
        
        // Simulate invalid response
        let nonHttpResponse = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        MockURLProtocol.stubResponse = nonHttpResponse
        
        // Act & Assert
        do {
            _ = try await sut.fetchData()
            XCTFail("Expected to throw invalidResponse error, but succeeded")
        } catch let error as Errors {
            XCTAssertEqual(error, .invalidResponse)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
        
    func testFetchNationPopulationData_withServerError_throwsServerError() async throws {
        // Arrange
        sut = USADataAPI<NationData>(urlString: urlString, session: session)
        
        // Simulate server error
        MockURLProtocol.statusCode = 500
        
        // Act & Assert
        do {
            _ = try await sut.fetchData()
            XCTFail("Expected to throw serverError, but succeeded")
        } catch let error as Errors {
            XCTAssertEqual(error, .serverError)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
        
    func testFetchNationPopulationData_withDecodingError_throwsDecodingError() async throws {
        // Arrange
        sut = USADataAPI<NationData>(urlString: urlString, session: session)
        
        // Simulate invalid JSON data
        let invalidJSONData = "{ invalid json }".data(using: .utf8)
        MockURLProtocol.stubResponseData = invalidJSONData
        
        // Act & Assert
        do {
            _ = try await sut.fetchData()
            XCTFail("Expected to throw decodingError, but succeeded")
        } catch let error as Errors {
            XCTAssertEqual(error, .decodingError)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
        
    func testFetchNationPopulationData_withValidResponse_returnsDecodedData() async throws {
        // Arrange
        sut = USADataAPI<NationData>(urlString: urlString, session: session)
        
        // Simulate valid JSON data
        
        let validJSONData = """
        {
            "data": [
                {
                    "ID Nation": "01000US",
                    "Nation": "United States",
                    "ID Year": 2022,
                    "Year": "2022",
                    "Population": 331097593,
                    "Slug Nation": "united-states"
                }
            ]
        }
        """.data(using: .utf8)
        
        MockURLProtocol.stubResponseData = validJSONData
        
        // Act
        do {
            let response: NationData = try await sut.fetchData()
            
            // Assert
            XCTAssertEqual(response.data.first?.idNation, "01000US")
            XCTAssertEqual(response.data.first?.nation, "United States")
            XCTAssertEqual(response.data.first?.idYear, 2022)
            XCTAssertEqual(response.data.first?.year, "2022")
            XCTAssertEqual(response.data.first?.population, 331097593)
            XCTAssertEqual(response.data.first?.slugNation, "united-states")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
