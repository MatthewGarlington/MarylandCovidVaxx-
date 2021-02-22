//
//  MDTotalCurrentHospital.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/22/21.
//

import Foundation


// Model For Total Current Hospitalizations

struct MDTotalCurrentHospital: Codable, Hashable {
    
    
    let features: [CurrentHospitalFeatures]?
    
    
}

struct CurrentHospitalFeatures: Codable, Hashable {
    
    
    let attributes: CurrentHospitalAttributes?
}

struct CurrentHospitalAttributes: Codable, Hashable {
    
    
    
    let DATE: Int?
    let Acute: Int?
    let ICU: Int?
    let Total: Int?
    
    
}
