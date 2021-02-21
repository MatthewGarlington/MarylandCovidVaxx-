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
    @ObservedObject var vm = VaccineLocationsModel()
    @State var annotations = [MKPointAnnotation]()
    @State var pinsArray = [MKPointAnnotation]()
    @State var showingPlaceDetails = false
    @State var showingEditScreen = false
    @State var selectedPlace: MKPointAnnotation?
    @State var showVaccineList = false
    @ObservedObject var casesModel = CovidMasterModel()
    

  
    
    
    var body: some View {
        GeometryReader { bounds in
            ScrollView {
              
                VStack {
                    HStack {
                        Text("Maryland Covid 19")
                          .font(.system(size: 28, weight: .bold))
                         
                        
                        Spacer()
                        
                        
        
                    }
                    .padding(.horizontal)
                    .padding(.leading, 14)
                    .padding(.top, 30)
                    
                    
            
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    WatchRingsView()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        .onTapGesture {
                            self.showContent = true
                        }
                }
                .blur(radius: self.active ? 20 : 0)
                
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
                        
                        // Case Row
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
            
            
            // Corrects the slide over layout on Ipad and Iphone SE Layout
            .frame(width: bounds.size.width)
            
            .offset(y: showProfile ? -450 : 0)
            .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
            .scaleEffect(showProfile ? 0.9 : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                
                
//                // Using the store before usees the observable object of the Contentful API and Combine instead of from our on array
//                VStack {
//
//                    HStack {
//                        Text("Vaccine Phase")
//                            .font(.title)
//                            .bold()
//                        Spacer()
//                    }.padding(.leading, 30)
//                    .offset(y: -10)
//                    .blur(radius: self.active ? 20 : 0)
//
//
//                    .padding(.bottom, 0)
////                    .offset(y: -60)
//
//
//
//                    VStack(spacing: 30) {
//                        ForEach(store.courses.indices, id: \.self) { index in
//                            GeometryReader { geometry in
//                                CourseView(
//                                    show: self.$store.courses[index].show,
//                                    active: self.$active, activeIndex: self.$activeIndex, course: self.store.courses[index],
//                                    index: index,
//                                    // Added the ability to change the color of the background upon dragging
//                                    activeView: self.$activeView, bounds: bounds, isScrollable: $isScrollable)
//                                    .offset(y: self.store.courses[index].show ? -geometry.frame(in: .global).minY : 0)
//                                    // The Following 3 animations occur in the other cards except the card that is pressed
//                                    .opacity(self.activeIndex != index && self.active ? 0 : 1)
//                                    .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
//                                    .offset(x: self.activeIndex != index && self.active ? bounds.size.width : 0)
//                            }
//                            // This adapts the ability to the cards to stack when the screen size is large, otherwise the normal layout
//                            .frame(height : horizontalSizeClass == .regular ? 80 : 280)
//                            .frame(maxWidth: self.store.courses[index].show ? 712 : getCardWidth(bounds: bounds))
//                            // This ZIndex Helps correct the Layout of cards showing on top of others during animation
//                            .zIndex(self.store.courses[index].show ? 0 : 1)
//                        }
//                    }
//                }
    
        }
        .disabled(self.active && !self.isScrollable ? true : false)
        
        }
    }
}

struct CasesRowOne: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var image: URL
    var logo: UIImage
    var color: UIColor
    
    
}

struct HospitalRow: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var image: URL
    var logo: UIImage
    var color: UIColor
    
    
}

struct CaseView: View {
    @ObservedObject var store = CourseStore()
    var index: Int
    var cases: CasesRowOne
    var width: CGFloat = 275
    var height: CGFloat = 275
  
    
    var body: some View {
   
        VStack {
            VStack {
                   
                    HStack(alignment: .top) {
                        Text(cases.title)
                            .font(.system(size: 24, weight: .bold))
                            .frame(width: 225, alignment: .leading)
                            .frame(height: 100)
                            .padding(.top, 35)
                            .foregroundColor(.white)
                        Spacer()
                    //    Image(uiImage: section.logo)
                        
                    }
                  Text(cases.text)
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 75)
                    
                }
            

        
        ZStack(alignment: .bottom) {
            
                WebImage(url: cases.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150)
                   //.padding(.bottom, 20)
                   //.blendMode(.darken)
                }
                
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)))
        .cornerRadius(30)
        .shadow(color: Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
      
        
    }
}
struct HospitalView: View {
    @ObservedObject var store = CourseStore()
    var index: Int
    var hospital: HospitalRow
    var width: CGFloat = 275
    var height: CGFloat = 275
  
    
    var body: some View {
   
        VStack {
            VStack {
                   
                    HStack(alignment: .top) {
                        Text(hospital.title)
                            .font(.system(size: 24, weight: .bold))
                            .frame(width: 225, alignment: .leading)
                            .frame(height: 100)
                            .padding(.top, 35)
                            .foregroundColor(.white)
                        Spacer()
                    //    Image(uiImage: section.logo)
                        
                    }
                  Text(hospital.text)
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 75)
                    
                }
            

        
        ZStack(alignment: .bottom) {
            
                WebImage(url: hospital.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150)
                   //.padding(.bottom, 20)
                   //.blendMode(.darken)
                }
                
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)))
        .cornerRadius(30)
        .shadow(color: Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
      
        
    }
}


struct CasesView_Previews: PreviewProvider {
    static var previews: some View {
        CasesView(showProfile: .constant(false), showContent: .constant(false), viewState: .constant(.zero)).environmentObject(UserStore())
    }
}
