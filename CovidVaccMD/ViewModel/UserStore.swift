//
//  UserStore.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//


import SwiftUI
import Combine

class UserStore: ObservableObject {
    // Setting the User Defaults in order to save Data after user closes the app to prevent having to login every time
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged") {
        didSet {
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
            
        }
        
    }
    @Published var showLogin = false
    
}
