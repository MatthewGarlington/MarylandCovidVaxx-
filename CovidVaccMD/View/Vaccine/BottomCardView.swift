//
//  BottomCardView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/22/21.
//

import SwiftUI

struct BottomCardView: View {
    @ObservedObject var totalVaccineViewModel = TotalVaccineData()
    @ObservedObject var positiveCasesViewModel = PositiveCasesViewModel()

    
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
                .padding()
            
            Text("Covd 19 Vaccine Percentages")
                .bold()
            
            VStack(spacing: 30) {
               
            HStack(spacing: 20) {
                RingView(color1: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), width: 100, height: 100, percent:  Double(totalVaccineViewModel.recentMDVaccineTotals?.features?[2].attributes?.Value ?? Double(0)), show: .constant(true))
                    .animation(Animation.easeInOut)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Percent of Population").modifier(FontModifer(style: .subheadline))
                    Text("Testing Positive")
                        .bold()
                        .modifier(FontModifer(style: .caption))
                }
                .padding()
                .background(Color("background3"))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                
            }
                HStack(spacing: 20) {
                    RingView(color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), color2: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), width: 100, height: 100, percent:  Double(totalVaccineViewModel.recentMDVaccineTotals?.features?[5].attributes?.Value ?? Double(0)), show: .constant(true))
                        .animation(Animation.easeInOut)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Percent of Population").modifier(FontModifer(style: .subheadline))
                        Text("2nd Doses Given")
                            .bold()
                            .modifier(FontModifer(style: .caption))
                    }
                    .padding()
                    .background(Color("background3"))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                    
                }
            }
            
            
            VStack(spacing: 20) {
                
                Text("Covd 19 Testing Percentages")
                    .bold()
            
            
            VStack {
               
            HStack(spacing: 20) {
                RingView2(color1: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), width: 100, height: 100, percent:  Double(positiveCasesViewModel.positiveCases?.features?[(positiveCasesViewModel.positiveCases?.features!.count)! - 1].attributes?.rolling_avg ?? Double(0)), show: .constant(true))
                    .animation(Animation.easeInOut)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Percent of Population").modifier(FontModifer(style: .subheadline))
                    Text("Testing Positive")
                        .bold()
                        .modifier(FontModifer(style: .caption))
                }
                .padding()
                .background(Color("background3"))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                
            }
       
            }
                
            
                
        }
            
            
        Spacer()
            
        }
        
//        .padding(.top, 8)
//        .padding(.horizontal, 20)
//        // Lets the bottom card with the Text Field to not take up the entire width of the screen
//        .frame(maxWidth: 712)
//        .frame(height: 800)
//        // Adding the BlurView Modifer to give a glass appearance
//        .background(BlurView(style: .systemThinMaterial))
//        .cornerRadius(30)
//        .shadow(radius: 20)
//        // This centers the change of the bottom card
//        .frame(maxWidth: .infinity)
       
    }
}


