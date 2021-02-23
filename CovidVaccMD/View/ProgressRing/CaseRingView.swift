//
//  CaseRingView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/22/21.
//

import SwiftUI



struct CaseRingView: View {
    
    @ObservedObject var positiveCasesViewModel = PositiveCasesViewModel()
    @ObservedObject var casesModel = CovidMasterModel()
    
    
    var body: some View {
        let epochTime2 = TimeInterval((positiveCasesViewModel.positiveCases?.features?[(positiveCasesViewModel.positiveCases?.features!.count)! - 1].attributes?.date ?? 0)) / 1000
        let date2 = Date(timeIntervalSince1970: epochTime2)
        let formate = date2.getFormattedDate(format: "MM-dd-yyyy")
//        let startMessage = casesModel.allMDHeader[casesModel.allMDHeader.count - 1].pospercentdiff ?? "nothing to show"
//        let startDouble = Double(startMessage)
//        let message   = String(format: "You've earned %@ points", arguments: [startMessage])
      

            HStack(spacing: 30) {
                
                
                HStack(spacing: 12) {
                    VStack(spacing: 0) {
                        RingView(color1: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), width: 100, height: 100, percent:  Double(positiveCasesViewModel.positiveCases?.features?[(positiveCasesViewModel.positiveCases?.features!.count)! - 1].attributes?.rolling_avg ?? Double(0)), show: .constant(true))
                   
                    }
                 
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Percent of Population").modifier(FontModifer(style: .subheadline))
                        Text("Testing Positive")
                            .bold()
                            .modifier(FontModifer(style: .caption))
                 
                       
                     

               

                        VStack {
                   
                            Text("Updated Last on: \(formate)")
                                .bold()
                                .modifier(FontModifer(style: .caption))
                        }.padding(.vertical, 10)
                    
                    }
                    .modifier(FontModifer())
              
                    
                }
                
                
                
            
                .frame(width: 250, height: 150)
                .padding(10)
                .background(Color("background3"))
                .cornerRadius(20)
                .modifier(ShadowModifer())
                .padding(.bottom, 20)
                



            }
    }
}


struct CaseRingView_Previews: PreviewProvider {
    static var previews: some View {
        CaseRingView()
    }
}

