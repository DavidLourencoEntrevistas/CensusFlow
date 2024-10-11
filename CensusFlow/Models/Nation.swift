//
//  Nation.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import Foundation

struct Nation : Decodable {
    
    let idNation : String
    let nation : String
    let idYear : Int
    let year : String
    let population: Int
    let slugNation: String
    
    enum CodingKeys: String, CodingKey{
        case idNation = "ID Nation"
        case nation = "Nation"
        case idYear = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugNation = "Slug Nation"
    }

}
