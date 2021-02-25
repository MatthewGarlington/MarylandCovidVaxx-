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
    
    
}

struct TestingGeometry: Codable, Hashable {
    
    let x: Double
    let y: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: y, longitude: x)
    }
    
    
}
