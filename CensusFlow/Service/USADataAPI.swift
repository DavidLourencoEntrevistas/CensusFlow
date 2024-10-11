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
    
    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    // Function to fetch USA nation population data
    func fetchNationPopulationData() async throws -> T {
        guard let url = URL(string: urlString) else{
            throw Errors.invalidUrl
        }
        
        do{
            let (data, response) = try await urlSession.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else{
                throw Errors.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else{
                throw Errors.serverError(statusCode: httpResponse.statusCode)
            }
            
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            
            return decodedResponse
            
        } catch let decodingError as DecodingError {
            throw Errors.decodingError(decodingError)
        } catch {
            throw Errors.unknownError(error)
        }
    }
}
