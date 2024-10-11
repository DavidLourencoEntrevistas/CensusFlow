//
//  USADataProtocol.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import Foundation


protocol USADataProtocol{
    associatedtype DataType: Decodable
    func fetchData() async throws -> DataType
}
