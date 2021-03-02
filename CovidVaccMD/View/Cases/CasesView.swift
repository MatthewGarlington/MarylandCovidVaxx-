//
//  CasesView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/21/21.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit

struct CasesView: View {
    @State var showProfile = false
    @State var showContent = false
    @State var showUpdate = false
    @State var viewState = CGSize.zero
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var isScrollable = false
    @State var show = false
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    
 

  
    
    
    var body: some View {
        
        
        ZStack {
            
            Color("background2")
                .edgesIgnoringSafeArea(.all)
            
      
            HomeBackgroundView(showProfile: $showProfile)
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(.all)
            
            HomeCases(showProfile: $showProfile, showContent: $showContent, viewState: $viewState)
        }
    }
}

struct CasesView_Previews: PreviewProvider {
    static var previews: some View {
        CasesView()
    }
}












struct HomeCases: View {
    @Binding var showProfile: Bool
    @Binding var showContent: Bool
    @State var showUpdate = false
    @Binding var viewState: CGSize
    @ObservedObject var store = CourseStore()
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var isScrollable = false
    @ObservedObject var totalVaccineViewModel = TotalVaccineData()
    @State var annotations = [MKPointAnnotation]()
    @State var pinsArray = [MKPointAnnotation]()
    @State var showingPlaceDetails = false
    @State var showingEditScreen = false
    @State var selectedPlace: MKPointAnnotation?
    @State var showVaccineList = false
    @ObservedObject var casesModel = CovidMasterModel()
    @ObservedObject var positiveCasesViewModel = PositiveCasesViewModel()
    @ObservedObject var currentlyHospitalizedViewModel = MDCurrentlyHospitalizedViewModel()
    @State var show = false
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
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
                                            
                                            TestView(index: index, tests: casesModel.testsRow[index])
                                                
                                                
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
                                            
                                            CaseView(index: index, cases: casesModel.casesRowOne[index])
                                                
                                                
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
                                            
                                            HospitalView(index: index, hospital: casesModel.hospitalRowTwo[index])
                                                
                                                
                                                .rotation3DEffect(Angle(degrees:
                                                                            Double(geometry.frame(in: .global).minX - 30) / -getAngleMulitplier(bounds: bounds)
                                                                        
                                                ), axis: (x: 0, y: 10.0, z: 0))
                                        }
                                        .frame(width: 275, height: 275)
                                    }
                                    
                                    ForEach(currentlyHospitalizedViewModel.hospitalRowTwo.indices, id: \.self) { index in
                                        GeometryReader { geometry in
                                            
                                            HospitalView(index: index, hospital: currentlyHospitalizedViewModel.hospitalRowTwo[index])
                                                
                                                
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
                                                
                                                DeathView(index: index, deaths: casesModel.confirmedDeaths[index])
                                                    
                                                    
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
    }
}
