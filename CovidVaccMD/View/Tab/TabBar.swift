//
//  TabBar.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//

import SwiftUI

struct TabBar: View {
    
    
    
    var body: some View {
        TabView {
            
            Home().tabItem {
                Image(systemName: "cross.case.fill")
                Text("Vaccine")
            }
            
            
            Cases()
                .tabItem {
                    Image(systemName: "cross.circle.fill")
                    Text("All Stats")
                }
            
            
            
            
        }
        .accentColor(Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)))
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar().environmentObject(UserStore())
    }
}

