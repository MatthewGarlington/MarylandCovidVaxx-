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

struct MDHistoricalVaccine: Codable, Hashable {
    
    
    let features: [MDHistoricalVaccineFeatures]?
    
    
}

struct MDHistoricalVaccineFeatures: Codable, Hashable {
    
    
    let attributes: MDHistoricalVaccineAttributes?
}

struct MDHistoricalVaccineAttributes: Codable, Hashable {

    let CumulativeTotalVaccinatedDoseOn: Int?
    let CumulativeTotalVaccinatedDoseTw: Int?
    let CumulativeTotalVaccinated: Int?
    let CumulativeTotalVaccinatedDate: Int?

}

