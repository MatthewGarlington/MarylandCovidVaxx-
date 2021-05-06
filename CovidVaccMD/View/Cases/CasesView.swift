//
//  CasesView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/21/21.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit





struct HomeCases: View {
    @ObservedObject var totalVaccineViewModel = TotalVaccineDataViewModel()
    @ObservedObject var casesModel = CovidMasterVM()
    @ObservedObject var positiveCasesViewModel = PositiveCasesViewModel()
    @ObservedObject var currentlyHospitalizedViewModel = MDCurrentlyHospitalizedViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @Binding var showProfile: Bool
    @Binding var showContent: Bool
    
    @State var showUpdate = false
    @Binding var viewState: CGSize
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @State var isScrollable = false
    @State var annotations = [MKPointAnnotation]()
    @State var pinsArray = [MKPointAnnotation]()
    @State var showingPlaceDetails = false
    @State var showingEditScreen = false
    @State var selectedPlace: MKPointAnnotation?
    @State var showVaccineList = false
    @State var show = false
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    @State var showCaseList = false
    @State var showTestList = false
    @State var showHospitalList = false
    @State var showDeathList = false
    @State var isLoading = false
    @State var isSuccessful = false
    @State var showLoadingLottie = false
 
    
    var body: some View {
        GeometryReader { bounds in
            ScrollView {
                
                VStack {
                    HStack {
                        Text("Maryland Covid 19")
                            .font(.system(size: 28, weight: .bold))
                        
                        
                        Spacer()
                        
                        Button(action: {self.showUpdate.toggle()}) {
                            Image(systemName: "mappin")
                                .foregroundColor(Color.red)
                                .font(.system(size: 16, weight: .medium))
                                .frame(width: 36, height: 36)
                                .background(Color("background3"))
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                            
                        }
                        .sheet(isPresented: $showUpdate) {
                            
                            TestingMapTabView()
                            
                            
                        }
                        
                        
                    }
                    .padding(.horizontal)
                    .padding(.leading, 14)
                    .padding(.top, 30)
                    
                    
                    
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        
                        
                        CaseRingView()
                            .padding(.horizontal, 30)
                            .padding(.bottom, 30)
                            .sheet(isPresented: $showContent, content: {
                                BottomCardView()
                            })
                            .onTapGesture {
                                showContent.toggle()
                                
                                
                            }
                    }
                    .blur(radius: self.active ? 20 : 0)
                    
                    
                    // Tests Row
                    
                    VStack {
                        
                        HStack {
                            Text("Test Totals")
                                .font(.title)
                                .bold()
                            Spacer()
                            
                            
                        }.padding(.leading, 30)
                        .offset(y: -40)
                        .blur(radius: self.active ? 20 : 0)
                        .padding(.bottom, 0)
                        
                        
                        Spacer()
                        
                        
                        
                        
                        VStack(spacing: 0) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                
                                HStack(spacing: 20) {
                                    
                                    
                                    ForEach(casesModel.testsRow.indices, id: \.self) { index in
                                        GeometryReader { geometry in
                                            
                                            TestView(index: index, tests: casesModel.testsRow[index], showTestList: $showTestList, isLoading: $isLoading)
                                                
                                                
                                                .rotation3DEffect(Angle(degrees:
                                                                            Double(geometry.frame(in: .global).minX - 30) / -getAngleMulitplier(bounds: bounds)
                                                                        
                                                ), axis: (x: 0, y: 10.0, z: 0))
                                        }
                                        .frame(width: 275, height: 275)
                                    }
                                    
                                }
                                
                                .padding(.horizontal, 30)
                                .padding(.top, 10)
                                .padding(.bottom, 50)
                            }
                            .offset(y: -30)
                            .blur(radius: self.active ? 20 : 0)
                            
                            
                        }
                    }
                    
                    
                    
                    // Case Row
                    
                    VStack {
                        
                        HStack {
                            Text("Case Totals")
                                .font(.title)
                                .bold()
                            Spacer()
                            
                            
                        }.padding(.leading, 30)
                        .offset(y: -40)
                        .blur(radius: self.active ? 20 : 0)
                        .padding(.bottom, 0)
                        
                        
                        Spacer()
                        
                        
                        
                        
                        VStack(spacing: 0) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                
                                HStack(spacing: 20) {
                                    
                                    
                                    ForEach(casesModel.casesRowOne.indices, id: \.self) { index in
                                        GeometryReader { geometry in
                                            
                                            CaseView(index: index, cases: casesModel.casesRowOne[index], showCaseList: $showCaseList, isLoading: $isLoading)
                                                
                                                
                                                .rotation3DEffect(Angle(degrees:
                                                                            Double(geometry.frame(in: .global).minX - 30) / -getAngleMulitplier(bounds: bounds)
                                                                        
                                                ), axis: (x: 0, y: 10.0, z: 0))
                                        }
                                        .frame(width: 275, height: 275)
                                    }
                                    
                                }
                                
                                .padding(.horizontal, 30)
                                .padding(.top, 10)
                                .padding(.bottom, 50)
                            }
                            .offset(y: -30)
                            .blur(radius: self.active ? 20 : 0)
                            
                            
                        }
                    }
                    // Hospital Row
                    VStack {
                        
                        HStack {
                            Text("Hospital Totals")
                                .font(.title)
                                .bold()
                            Spacer()
                        }.padding(.leading, 30)
                        .offset(y: -40)
                        .blur(radius: self.active ? 20 : 0)
                        .padding(.bottom, 0)
                        
                        
                        Spacer()
                        
                        // Hospital Row
                        VStack(spacing: 0) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                
                                HStack(spacing: 20) {
                                    
                                    ForEach(casesModel.hospitalRowTwo.indices, id: \.self) { index in
                                        GeometryReader { geometry in
                                            
                                            HospitalView(index: index, hospital: casesModel.hospitalRowTwo[index], showHospitalList: $showHospitalList, isLoading: $isLoading)
                                                
                                                
                                                .rotation3DEffect(Angle(degrees:
                                                                            Double(geometry.frame(in: .global).minX - 30) / -getAngleMulitplier(bounds: bounds)
                                                                        
                                                ), axis: (x: 0, y: 10.0, z: 0))
                                        }
                                        .frame(width: 275, height: 275)
                                    }
                                    
                                    ForEach(currentlyHospitalizedViewModel.hospitalRowTwo.indices, id: \.self) { index in
                                        GeometryReader { geometry in
                                            
                                            HospitalView(index: index, hospital: currentlyHospitalizedViewModel.hospitalRowTwo[index], showHospitalList: $showHospitalList, isLoading: $isLoading)
                                                
                                                
                                                .rotation3DEffect(Angle(degrees:
                                                                            Double(geometry.frame(in: .global).minX - 30) / -getAngleMulitplier(bounds: bounds)
                                                                        
                                                ), axis: (x: 0, y: 10.0, z: 0))
                                        }
                                        .frame(width: 275, height: 275)
                                    }
                                    
                                }
                                
                                .padding(.horizontal, 30)
                                .padding(.top, 10)
                                .padding(.bottom, 50)
                            }
                            .offset(y: -30)
                            .blur(radius: self.active ? 20 : 0)
                            
                            
                        }
                        
                        // Death Row
                        
                        VStack {
                            
                            HStack {
                                Text("Death Totals")
                                    .font(.title)
                                    .bold()
                                Spacer()
                            }.padding(.leading, 30)
                            .offset(y: -40)
                            .blur(radius: self.active ? 20 : 0)
                            .padding(.bottom, 0)
                            
                            
                            Spacer()
                            
                            // Case Row
                            VStack(spacing: 0) {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    
                                    HStack(spacing: 20) {
                                        
                                        ForEach(casesModel.confirmedDeaths.indices, id: \.self) { index in
                                            GeometryReader { geometry in
                                                
                                                DeathView(index: index, deaths: casesModel.confirmedDeaths[index], showDeathList: $showDeathList, isLoading: $isLoading)
                                                    
                                                    
                                                    .rotation3DEffect(Angle(degrees:
                                                                                Double(geometry.frame(in: .global).minX - 30) / -getAngleMulitplier(bounds: bounds)
                                                                            
                                                    ), axis: (x: 0, y: 10.0, z: 0))
                                            }
                                            .frame(width: 275, height: 275)
                                        }
                                        
                                        
                                        
                                    }
                                    
                                    .padding(.horizontal, 30)
                                    .padding(.top, 10)
                                    .padding(.bottom, 50)
                                }
                                .offset(y: -30)
                                .blur(radius: self.active ? 20 : 0)
                                
                                
                            }
                        }
                    }
                    
                    
                }
                
                
                // Corrects the slide over layout on Ipad and Iphone SE Layout
                .frame(width: bounds.size.width)
                
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                
                
                
                
            }
            .disabled(self.active && !self.isScrollable ? true : false)
            
        }
        
        
        .blur(radius: showCaseList ? 5 : 0)
        .blur(radius: showTestList ? 5 : 0)
        .blur(radius: showHospitalList ? 5 : 0)
        .blur(radius: showDeathList ? 5 : 0)
    

        if showCaseList {
            
            
            ZStack {
                    ZStack {
                
               
                        Spacer()
                        
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white.opacity(0.1))
                            .onTapGesture {
                                withAnimation {
                                self.showCaseList = false
                        
                                }
                            }
           
                CasesList()
                        
                        if isLoading {
                            
                            SuccessView()
                                .offset(y: 5)
                            
                              
                            
                        }
              
                
                    VStack {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .frame(width: 36, height: 36)
                    .background(Color.black)
                    .clipShape(Circle())
                    .offset(x: 175, y: -350)
                    .onTapGesture {
                        self.showCaseList = false
                    }
                            
                        
               
            }
            
           
      
            // The added scale effect is for the drag gesture of the animation
            .scaleEffect(1 - self.activeView.height / 1000)
            // This allows the cards to rotate upon the drag gesture to either side
            .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)),
                axis: (x: 0.0, y: 10.0, z: 0.0))
            .hueRotation(Angle(degrees: Double(self.activeView.height)))
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
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
                    if self.activeView.height > 50  {
                        
                        withAnimation {
                        self.showCaseList = false
                 
                        }
                    }
                    
                    self.activeView = .zero
                    
                    
                }
            )
        }
            
            .transition(.scale)
     
            
        }
            if showTestList {

                
    
                
                     ZStack {
                             ZStack {
                         
                        
                                 Spacer()
                                 
                                     .frame(maxWidth: .infinity, maxHeight: .infinity)
                                     .background(Color.white.opacity(0.1))
                                     .onTapGesture {
                                         withAnimation {
                                         self.showTestList = false
                                 
                                         }
                                     }
                    
                         TestsList()
                              
                                if isLoading {
                                    
                                    SuccessView()
                                        .offset(y: 5)
                                      
                                    
                                }
                       
                         
                             VStack {
                                 Image(systemName: "xmark")
                                     .font(.system(size: 16, weight: .medium))
                                     .foregroundColor(.white)
                             }
                             .frame(width: 36, height: 36)
                             .background(Color.black)
                             .clipShape(Circle())
                             .offset(x: 175, y: -350)
                             .onTapGesture {
                                 self.showTestList = false
                             }
                                     
                                 
                        
                     }
                     
                    
               
                     // The added scale effect is for the drag gesture of the animation
                     .scaleEffect(1 - self.activeView.height / 1000)
                     // This allows the cards to rotate upon the drag gesture to either side
                     .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)),
                         axis: (x: 0.0, y: 10.0, z: 0.0))
                     .hueRotation(Angle(degrees: Double(self.activeView.height)))
                     .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
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
                             if self.activeView.height > 50  {
                                 
                                 withAnimation {
                                 self.showTestList = false
                          
                                 }
                             }
                             
                             self.activeView = .zero
                             
                             
                         }
                     )
                 }
                     
                     .transition(.scale)
                
            
            }
     
            
        
        
        
        if showHospitalList {
            
            
                 ZStack {
                         ZStack {
                     
                    
                             Spacer()
                             
                                 .frame(maxWidth: .infinity, maxHeight: .infinity)
                                 .background(Color.white.opacity(0.1))
                                 .onTapGesture {
                                     withAnimation {
                                     self.showHospitalList = false
                             
                                     }
                                 }
                
                     HospitalList()
                            
                            if isLoading {
                                
                                SuccessView()
                                  
                                    .offset(y: 5)
                                
                            }
                   
                     
                         VStack {
                             Image(systemName: "xmark")
                                 .font(.system(size: 16, weight: .medium))
                                 .foregroundColor(.white)
                         }
                         .frame(width: 36, height: 36)
                         .background(Color.black)
                         .clipShape(Circle())
                         .offset(x: 175, y: -350)
                         .onTapGesture {
                             self.showHospitalList = false
                         }
                                 
                             
                    
                 }
                 
                
           
                 // The added scale effect is for the drag gesture of the animation
                 .scaleEffect(1 - self.activeView.height / 1000)
                 // This allows the cards to rotate upon the drag gesture to either side
                 .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)),
                     axis: (x: 0.0, y: 10.0, z: 0.0))
                 .hueRotation(Angle(degrees: Double(self.activeView.height)))
                 .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
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
                         if self.activeView.height > 50  {
                             
                             withAnimation {
                             self.showHospitalList = false
                      
                             }
                         }
                         
                         self.activeView = .zero
                         
                         
                     }
                 )
             }
                 
                 .transition(.scale)
            
        }
        
        if showDeathList {
            
            
            ZStack {
                    ZStack {
                
               
                        Spacer()
                        
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white.opacity(0.1))
                            .onTapGesture {
                                withAnimation {
                                self.showDeathList = false
                        
                                }
                            }
           
                DeathList()
                        if isLoading {
                            
                            SuccessView()
                                .offset(y: 5)
                              
                            
                        }
              
                
                    VStack {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .frame(width: 36, height: 36)
                    .background(Color.black)
                    .clipShape(Circle())
                    .offset(x: 175, y: -350)
                    .onTapGesture {
                        self.showDeathList = false
                    }
                            
                        
               
            }
            
           
      
            // The added scale effect is for the drag gesture of the animation
            .scaleEffect(1 - self.activeView.height / 1000)
            // This allows the cards to rotate upon the drag gesture to either side
            .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)),
                axis: (x: 0.0, y: 10.0, z: 0.0))
            .hueRotation(Angle(degrees: Double(self.activeView.height)))
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
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
                    if self.activeView.height > 50  {
                        
                        withAnimation {
                        self.showDeathList = false
                 
                        }
                    }
                    
                    self.activeView = .zero
                    
                    
                }
            )
        }
            
            .transition(.scale)
            
        }
        
     
     
            
        
 
   
    }
}




