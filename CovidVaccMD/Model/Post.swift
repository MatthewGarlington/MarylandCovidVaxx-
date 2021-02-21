//
//  Post.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/21/21.
//

import Foundation


struct Post: Codable, Identifiable {
    
    let id = UUID()
    var title: String
    var body: String
    
}
