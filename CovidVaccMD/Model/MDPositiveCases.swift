//
//  MDPositiveCases.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/22/21.
//

import Foundation


// Model For Positive Cases
struct MDPositiveCases: Codable, Hashable {
    
    
    let features: [CaseFeatures]?
    
    
}

struct CaseFeatures: Codable, Hashable {
    
    
    let attributes: CaseAttributes?
}

struct CaseAttributes: Codable, Hashable {
    
    
    
    let date: Int?
    let number_of_tests: Int?
    let number_of_positives: Int?
    let percent_positive: Double?
    let rolling_avg: Double?
    
    
}
