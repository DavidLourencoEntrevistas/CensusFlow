//
//  State.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import Foundation

struct State : Decodable {
    
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
    
    
}
