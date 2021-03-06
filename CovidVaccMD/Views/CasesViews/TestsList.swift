//
//  TestsList.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/25/21.
//

import SwiftUI

struct TestsList: View {
    @ObservedObject var casesModel = CovidMasterVM()
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @State var isScrollable = false
    
 

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
                    
                    Text("History of Total Tests")
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

                                                Text("Total Tests:")
                                                    .font(.system(size: 20, weight: .bold))

                                                Text("\(cases.totaltests ?? "")")
                                                    .font(.system(size: 20, weight: .semibold))
                                            }



                                        VStack(alignment: .leading) {
                                            Text("+\(cases.testsdelta ?? "")")
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
                    
                
            .gesture(
                
                /// The Show condistional accompanied by the : nil at the end, give the ability for only the card to show the drag gesture upon selection
      
                DragGesture().onChanged  { value in
                    
                    // This guard statement allows the full size card to be dismissed after dragging to a translation height of 300
                    guard value.translation.height < 300 else { return }
                    
                    // This guard statement lets the drag animations to not take place upon dragging up on the screen
                    
                    guard value.translation.height > 50 else { return }
                    
                    self.activeView = value.translation
                    
                }
                
                .onEnded { value in
            
                // This tells the full screen card view to close upon dragging to 50
                    if self.activeView.height > 50 && self.showCard == true {
                        
                   
                        self.showCard = false
                 
                        
                    }
                    
                    self.activeView = .zero
                    
                    
                }
            
            )

                
           
            }
            }
        }
    
}
}


struct TestsList_Previews: PreviewProvider {
    static var previews: some View {
        TestsList()
    }
}
