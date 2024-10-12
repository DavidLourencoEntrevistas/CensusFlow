//
//  State.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import Foundation

// Change name to prevent error with keyword state
struct StateModel : Codable {
    
    let id: UUID
    let idState : String
    let state : String
    let idYear : Int
    let year : String
    let population: Int
    let slugState: String
    
    enum CodingKeys: String, CodingKey{
        case idState = "ID State"
        case state = "State"
        case idYear = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugState = "Slug State"
    }
    
    init(idState: String, state: String, idYear: Int, year: String, population: Int, slugState: String) {
        
        self.id = UUID()
        self.idState = idState
        self.state = state
        self.idYear = idYear
        self.year = year
        self.population = population
        self.slugState = slugState
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.idState = try container.decode(String.self, forKey: .idState)
        self.state = try container.decode(String.self, forKey: .state)
        self.idYear = try container.decode(Int.self, forKey: .idYear)
        self.year = try container.decode(String.self, forKey: .year)
        self.population = try container.decode(Int.self, forKey: .population)
        self.slugState = try container.decode(String.self, forKey: .slugState)
        
        self.id = UUID()
    }
    
}
