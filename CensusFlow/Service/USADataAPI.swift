//
//  USADataAPI.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import Foundation

class USADataAPI<T: Decodable> : USADataProtocol {
    
    private var urlString : String
    private var urlSession : URLSession
    
    init(urlString: String, session: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = session
    }
    
    // Function to fetch USA nation population data
    func fetchData() async throws -> T {
        
        guard let url = URL(string: urlString), url.scheme != nil else{
            throw Errors.invalidUrl
        }
        
        let (data, response) = try await urlSession.data(from: url)
            
        guard let httpResponse = response as? HTTPURLResponse else{
            throw Errors.invalidResponse
        }
            
        guard (200...299).contains(httpResponse.statusCode) else {
            throw Errors.serverError
        }
            
        do{
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                
            return decodedResponse
            
        } catch {
            
            throw Errors.decodingError
            
        }
    }
}
