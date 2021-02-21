//
//  MDVaccine.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/21/21.
//

import Foundation


struct MDTotalVaccine: Codable, Hashable {
    
    
    let features: [Features]?
    
    
}

struct Features: Codable, Hashable {
    
    
    let attributes: Attributes?
}

struct Attributes: Codable, Hashable {
    
    
    
    let Metric: String?
    let Value: Double?
    
    
}
