//
//  MDVaccineLocations.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/21/21.
//

import Foundation
import MapKit


struct MDVaccineLocations: Codable, Hashable, Identifiable {
    
    
    let id = UUID()
    let features: [VaccineLocationsFeatures]?
    
    
    
}

struct VaccineLocationsFeatures: Codable, Hashable, Identifiable {
    
    let id = UUID()
    let attributes: VaccineLocationAttributes?
    let geometry: Geometry?
    
}

struct VaccineLocationAttributes: Codable, Hashable, Identifiable {
    
    let id = UUID()
    let name: String?
    let fulladdr: String?
    let municipality: String?
    let ActiveYesNo: String?
    let operationalhours: String?
    let cost_notes: String?
    let schedule_url: String?
    let online_scheduling: String?
    let scheduling_contact: String?
    let scheduling_contact_phone: String?
    let scheduling_contact_email: String?
    let test_pcr: String?
    let website_url: String?
    let created_date: Int?
    let last_edited_date: Int?
    let site_type: String?
    
    
}

struct Geometry: Codable, Hashable {
    
    let x: Double
    let y: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: y, longitude: x)
    }
    
    
}
