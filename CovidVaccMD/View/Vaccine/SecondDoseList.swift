//
//  SecondDoseList.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 3/1/21.
//

import SwiftUI

struct SecondDoseList: View {
    @ObservedObject var vaccineHistoricalViewModel = HistoricalVaccineData()
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
 

    var body: some View {
 
                
        VStack {
     
            ZStack {
                
       
                   
                
                BlurView(style: .systemUltraThinMaterial)
                    
                    .frame(width: 400, height: showCard ? 900 : 400, alignment: .center)
                    .cornerRadius(40)
                    .ignoresSafeArea(showCard ? .all : .keyboard)
                   
                
                VStack {
                    
                    ZStack {
                        
                        BlurView(style: .systemUltraThinMaterialDark)
                            
                            .frame(width: 300, height: 50, alignment: .center)
                            .cornerRadius(20)
                    
                    Text("History of Second Doses Vaccines")
                        .bold()
                       
                        
                        
                        
                        
                    }
                    .offset(y: showCard ? 50 : 0)
                    .padding()
                
                List {
                
            
                        VStack {
                        ForEach(vaccineHistoricalViewModel.recentMDVaccineTotals?.features?.reversed() ?? [], id: \.self) { vaccine in
                   
                                
                                HStack {

                                    
                        
                                    VStack(alignment: .leading, spacing: 12) {
                                       
                                        
                                        HStack(spacing: 40) {
                                             
                                            
                                           
                                            
                                            Text("\((vaccine.attributes?.CumulativeTotalVaccinatedDate?.getDateFromCrazyInt(date: vaccine.attributes!.CumulativeTotalVaccinatedDate!))!):")
                                                    .font(.system(size: 20, weight: .bold))
                                   
                                 
                                            VStack(alignment: .leading) {
                                                Text("\(vaccine.attributes?.CumulativeTotalVaccinatedDoseTw ?? 0)")
                                                        .font(.system(size: 20, weight: .semibold))
                                                
                                             
                                            }

                                        }
                                    }
                                }
                                .padding(.vertical, 8)
                        }
                        
                            
                        }
                 
              
                }
                
            
                
                
                .frame(maxWidth: showCard ? 340 : 340)
                .frame(maxHeight: showCard ? 800 : 220)
             //   .background(Color.black)
        //              .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? 80 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    showCard.toggle()
                  
            
            }

                
           
            }
            }
        }
    
}
}

struct SecondDoseList_Previews: PreviewProvider {
    static var previews: some View {
        SecondDoseList()
    }
}
