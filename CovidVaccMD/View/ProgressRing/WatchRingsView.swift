//
//  WatchRingsView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/22/21.
//

import SwiftUI

struct WatchRingsView: View {
    
    @ObservedObject var totalVaccineViewModel = TotalVaccineData()
    var body: some View {
        HStack(spacing: 30) {
            
            
            VStack(spacing: 12) {
                RingView(color1: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), width: 100, height: 100, percent:  Double(totalVaccineViewModel.recentMDVaccineTotals?.features?[2].attributes?.Value ?? Double(0)), show: .constant(true))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Percent of Population").modifier(FontModifer(style: .subheadline))
                    Text("1st Dose Received")
                        .bold()
                        .modifier(FontModifer(style: .caption))
                    
                }
                .modifier(FontModifer())
          
                
            }
            
            
            
        
            .frame(width: 150, height: 200)
            .padding(10)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifer())
            .padding(.bottom, 20)
            VStack(spacing: 12) {
                RingView(color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), color2: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), width: 100, height: 100, percent:  Double(totalVaccineViewModel.recentMDVaccineTotals?.features?[5].attributes?.Value ?? Double(0)), show: .constant(true))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Percent of Population").modifier(FontModifer(style: .subheadline))
                    Text("2nd Doses Given")
                        .bold()
                        .modifier(FontModifer(style: .caption))
                    
                }
                .modifier(FontModifer())
          
                
            }
            
            
            
        
            .frame(width: 150, height: 200)
            .padding(10)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifer())
            .padding(.bottom, 20)
            


        }
    }
}
