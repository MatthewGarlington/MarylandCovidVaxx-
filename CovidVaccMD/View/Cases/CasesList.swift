//
//  CasesList.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/22/21.
//

import SwiftUI



struct CasesList: View {
    @ObservedObject var casesModel = CovidMasterModel()
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
 

    var body: some View {
 
                
        VStack {
     
            ZStack {
                
       
                   
                
                BlurView(style: .systemUltraThinMaterial)
                    
                    .frame(width: 400, height: showCard ? 780 : 400, alignment: .center)
                    .cornerRadius(40)
                    .offset(y: showCard ? -20 : 0)
                    .ignoresSafeArea(showCard ? .all : .keyboard)
                 
                   
                
                VStack {
                    
                    ZStack {
                        
                        BlurView(style: .systemUltraThinMaterialDark)
                            
                            .frame(width: 250, height: 50, alignment: .center)
                            .cornerRadius(20)
                    
                    Text("History of Total Vaccines")
                        .bold()
                       
                        
                        
                        
                        
                    }
                    .offset(y: showCard ? -40 : 0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                    .padding()
                
                List {
                
            
                    VStack {
                            ForEach(casesModel.allMDHeader.reversed(), id: \.self) { cases in
                   
                                
                                VStack {

                                    Text("\(cases.reportdate?.getDateFormatterForString(dateString: cases.reportdate ?? "") ?? ""):")
                                        .font(.system(size: 20, weight: .bold))
                                       
                                    Spacer()
                                    
                        
                                    VStack(alignment: .leading) {
                                        HStack(spacing: 10) {
                                            HStack {

                                                Text("Total Cases:")
                                                    .font(.system(size: 20, weight: .bold))

                                                Text("\(cases.totalcases ?? "")")
                                                    .font(.system(size: 20, weight: .semibold))
                                            }



                                        VStack(alignment: .leading) {
                                            Text("+\(cases.casedelta ?? "")")
                                                .font(.caption)
                                                .fontWeight(.bold)
                                                .foregroundColor(.primary)
                                            Spacer()
                                        }
                                        }
                                    }
                                }
                                .padding(.vertical, 8)
                        }
                            
                            
                        }
                 
              
                }
                
            
                
                
                .frame(maxWidth: showCard ? 340 : 340)
                .frame(maxHeight: showCard ? 600 : 220)
             //   .background(Color.black)
        //              .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -40 : 0)
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



struct CasesList_Previews: PreviewProvider {
    static var previews: some View {
        CasesList()
    }
}
