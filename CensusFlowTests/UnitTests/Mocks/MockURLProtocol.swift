//
//  MockURLProtocol.swift
//  CensusFlowTests
//
//  Created by David Lourenço on 11/10/2024.
//

import Foundation
@testable import CensusFlow

class MockURLProtocol: URLProtocol {
    
    static var stubResponseData: Data?
    static var error: Error?
    static var statusCode: Int = 200
    static var stubResponse: URLResponse?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = MockURLProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        } else {

            let response: URLResponse
            if let customResponse = MockURLProtocol.stubResponse {
                response = customResponse
            } else {
                response = HTTPURLResponse(
                    url: self.request.url!,
                    statusCode: MockURLProtocol.statusCode,
                    httpVersion: nil,
                    headerFields: nil)!
            }
            
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
            if let stubData = MockURLProtocol.stubResponseData {
                self.client?.urlProtocol(self, didLoad: stubData)
            }
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        // Required but no implementation needed
    }
}
