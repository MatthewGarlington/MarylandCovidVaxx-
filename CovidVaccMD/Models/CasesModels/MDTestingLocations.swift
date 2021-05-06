//
//  MDTestingLocations.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/25/21.
//

import Foundation
import MapKit


struct MDTestingLocations: Codable, Hashable, Identifiable {
    
    
    let id = UUID()
    let features: [TestingLocationsFeatures]?
    
    
    
}

struct TestingLocationsFeatures: Codable, Hashable, Identifiable {
    
    let id = UUID()
    let attributes: TestingLocationAttributes?
    let geometry: Geometry?
    
}

struct TestingLocationAttributes: Codable, Hashable, Identifiable {
    
    let id = UUID()
    let name: String?
    let fulladdr: String?
    let municipality: String?
    let EditDate: Int?
    let ActiveYesNo: String?
    let site_type: String?
    let appt_required: String?
    let operationalhours: String?
    let docorder_required: String?
    let costfree: String?
    let cost_outpocket: String?
    let drivethru: String?
    let transitAccess: String?
    let test_antigen: String?
    let test_antibody: String?
    let other_notes: String?
    let insurance_accepted: String?
    let medicaid: String?
    let cost_other: String?
    let cost_notes: String?
    let test_rapid: String?
    let schedule_url: String?
    let online_scheduling: String?
    let scheduling_contact: String?
    let scheduling_contact_phone: String?
    let scheduling_contact_email: String?
    let test_pcr: String?
    let website_url: String?
    let test_pediatric: String?
    let multi_language: String?
    let created_date: Int?
    
    
}

struct TestingGeometry: Codable, Hashable {
    
    let x: Double
    let y: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: y, longitude: x)
    }
    
    
}
