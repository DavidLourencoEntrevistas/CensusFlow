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
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        if let error = MockURLProtocol.error{
            
            let stubError = NSError(domain: "StubNSError", code: -99, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
            
            self.client?.urlProtocol(self, didFailWithError: stubError)
            
        }else{
            
            self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
            
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
