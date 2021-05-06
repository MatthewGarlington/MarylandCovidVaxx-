//
//  UpdateStore.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    
    @Published var updates: [Update] = updateData
    
}

