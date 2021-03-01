//
//  HomeBackgroundView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/22/21.
//

import SwiftUI

struct HomeBackgroundView: View {
    @Binding var showProfile: Bool
    
    
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [Color("background2"), Color("background1")]), startPoint: .top, endPoint: .bottom)
                .frame(height: 200)
            Spacer()
        }
        .background(Color("background1"))
        
        
        .clipShape(RoundedRectangle(cornerRadius: showProfile ? 30 : 0, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
    }
}
