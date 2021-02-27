//
//  HospitalRow.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/22/21.
//

import SwiftUI


struct HospitalRow: Identifiable {
    var id = UUID()
    var title: String
    var text: Int
    var image: URL
    var logo: UIImage
    var color: UIColor
    
    
}
