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

    let VACCINATION_DATE: Int?
    let FirstDailyDose: Int?
    let FirstDoseDelta: Int?
    let SecondDoseDelta: Int?
    let SingleDoseDelta: Int?
    let FirstDoseCumulative: Int?
    let SecondDailyDose: Int?
    let SecondDoseCumulative: Int?
    let SingleDailyDose: Int?
    let SingleDoseCumulative: Int?
    let AtleastOneVaccine: Int?
    let AtleastOneVaccineCumulative: Int?
    let CompletedVax: Int?
    let CompletedVaxCumulative: Int?
    let FirstSecondSingleVaccinations: Int?
    let FirstSecondSingleVaccinationsCu: Int?
    let TotalVaccineDosesDelivered: Int?
    let FirstDoseDistributed: Int?
    let SingleDoseDistributed: Int?
    let SingleDosePercentVaccinated: Int?
    let VaxCompletedDistributed: Int?
    let FirstSecondSingleDistributed: Int?

}

