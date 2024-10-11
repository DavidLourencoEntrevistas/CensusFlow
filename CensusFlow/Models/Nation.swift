//
//  Nation.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import Foundation

struct Nation : Codable {
    
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
    
    init(idNation: String, nation: String, idYear: Int, year: String, population: Int, slugNation: String) {
        self.idNation = idNation
        self.nation = nation
        self.idYear = idYear
        self.year = year
        self.population = population
        self.slugNation = slugNation
    }

}
