//
//  WatchRingsView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/22/21.
//

import SwiftUI

struct VaccinePercentHeaderView: View {
    
    @ObservedObject var viewModel = TotalVaccineDataViewModel()
    var body: some View {
        HStack(spacing: 30) {

            VStack(spacing: 12) {
                RingView(color1: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), width: 100, height: 100, percent:  Double(viewModel.recentMDVaccineTotals?.features?[16].attributes?.Value ?? Double(0)), show: .constant(true))

                VStack(alignment: .leading, spacing: 4) {
                    Text("Percent of Population").modifier(FontModifer(style: .subheadline))
                    Text("Fully Vaccinated")
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
                RingView(color1: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), color2: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), width: 100, height: 100, percent:  Double(viewModel.recentMDVaccineTotals?.features?[8].attributes?.Value ?? Double(0)), show: .constant(true))
                
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
                RingView(color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), color2: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), width: 100, height: 100, percent:  Double(viewModel.recentMDVaccineTotals?.features?[10].attributes?.Value ?? Double(0)), show: .constant(true))
                
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
            
            VStack(spacing: 12) {
                RingView(color1: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), color2: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), width: 100, height: 100, percent:  Double(viewModel.recentMDVaccineTotals?.features?[12].attributes?.Value ?? Double(0)), show: .constant(true))

                VStack(alignment: .leading, spacing: 4) {
                    Text("Percent of Population").modifier(FontModifer(style: .subheadline))
                    Text("One Shot Given")
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
