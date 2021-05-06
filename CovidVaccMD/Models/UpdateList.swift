//
//  UpdateList.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct Update: Identifiable {
    
    var id = UUID()
    var image: URL
    var title: String
    var text: String
    var date: String
    
}



let updateData = [
    Update(image:  URL(string: "https://image.freepik.com/free-vector/coronavirus-covid-19-medical-background-with-technology-styled-schematic-grid-viruses-floating-blue-purple-scientific-abstraction_116953-976.jpg")!, title: "SwiftUI Advanced", text: "Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.", date: "JAN 1"),


]
