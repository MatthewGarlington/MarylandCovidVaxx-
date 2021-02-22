//
//  MDHeader.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/22/21.
//

import Foundation


struct MDHeader: Codable, Hashable {
    
    let filter: String?
    let reportdate: Date?
    let totalcases: String?
    let casedelta: String?
    let totaltests: String?
    let testsdelta: String?
    let postestpercent: String?
    let pospercentdiff: String?
    let negativetests: String?
    let negdelta: String?
    let bedstotal: String?
    let bedsacute: String?
    let bedsicu: String?
    let bedsdelta: String?
    let total_hospitalized: String?
    let hospitalizeddelta: String?
    let total_released: String?
    let releaseddelta: String?
    
}
