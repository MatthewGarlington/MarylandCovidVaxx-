//
//  HomeView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit

struct HomeView: View {
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
//    @State var centerCoordinate = CLLocationCoordinate2D()
    @State var showingPlaceDetails = false
    @State var showingEditScreen = false
    @State var selectedPlace: MKPointAnnotation?
//
  
    
    
    var body: some View {
        GeometryReader { bounds in
            ScrollView {
              
                VStack {
                    HStack {
                        Text("Maryland Vaccination")
                          .font(.system(size: 28, weight: .bold))
                         
                        
                        Spacer()
                        
                      //  AvatarView(showProfile: $showProfile)
                        
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
                            
                                
                              
                              
                                    
                                    VStack {
                                        Spacer()
                                        MapViewMaryland(annotations: $annotations, pinsArray: $pinsArray, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)
                                            
                                            .frame(width: 420, height: 700)
                                            .cornerRadius(50)
                                            .alert(isPresented: $showingPlaceDetails) {
                                    
                                    
                                        Alert(title: Text(selectedPlace?.title ?? ""), message: Text(selectedPlace?.subtitle ?? ""))
                                        }
                                    }
                                
                                
                            
                            
                        
                           
 
                        }
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
                            Text("All Doses")
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
                                    // This gives the top SecitonView the ability to link to Contentful
                                    ForEach(totalVaccineViewModel.sections.indices, id: \.self) { index in
                                        GeometryReader { geometry in
                                            
                                            
                                        
                                            SectionView(index: index, section: self.totalVaccineViewModel.sections[index], width: 275, height: 275)
                                            
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
                            
                            VStack {
                                
                                HStack {
                                    Text("First Doses")
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
                                            // This gives the top SecitonView the ability to link to Contentful
                                            ForEach(totalVaccineViewModel.sectionsRowTwo.indices, id: \.self) { index in
                                                GeometryReader { geometry in
                                                    
                                                    
                                                
                                                    SectionSecondRowView(index: index, section: self.totalVaccineViewModel.sectionsRowTwo[index], width: 275, height: 275)
                                                    
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
                                    Text("Second Doses")
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
                                            // This gives the top SecitonView the ability to link to Contentful
                                            ForEach(totalVaccineViewModel.sectionsRowThree.indices, id: \.self) { index in
                                                GeometryReader { geometry in
                                                    
                                                    
                                                
                                                    SectionThirdRowView(index: index, section: self.totalVaccineViewModel.sectionsRowThree[index], width: 275, height: 275)
                                                    
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
                
   
                
            }
            
            
            // Corrects the slide over layout on Ipad and Iphone SE Layout
            .frame(width: bounds.size.width)
            
            .offset(y: showProfile ? -450 : 0)
            .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
            .scaleEffect(showProfile ? 0.9 : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                
                
                // Using the store before usees the observable object of the Contentful API and Combine instead of from our on array
                VStack {
                    
                    HStack {
                        Text("Vaccine Phase")
                            .font(.title)
                            .bold()
                        Spacer()
                    }.padding(.leading, 30)
                    .offset(y: -10)
                    .blur(radius: self.active ? 20 : 0)


                    .padding(.bottom, 0)
//                    .offset(y: -60)

           
                    
                    VStack(spacing: 30) {
                        ForEach(store.courses.indices, id: \.self) { index in
                            GeometryReader { geometry in
                                CourseView(
                                    show: self.$store.courses[index].show,
                                    active: self.$active, activeIndex: self.$activeIndex, course: self.store.courses[index],
                                    index: index,
                                    // Added the ability to change the color of the background upon dragging
                                    activeView: self.$activeView, bounds: bounds, isScrollable: $isScrollable)
                                    .offset(y: self.store.courses[index].show ? -geometry.frame(in: .global).minY : 0)
                                    // The Following 3 animations occur in the other cards except the card that is pressed
                                    .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                    .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                    .offset(x: self.activeIndex != index && self.active ? bounds.size.width : 0)
                            }
                            // This adapts the ability to the cards to stack when the screen size is large, otherwise the normal layout
                            .frame(height : horizontalSizeClass == .regular ? 80 : 280)
                            .frame(maxWidth: self.store.courses[index].show ? 712 : getCardWidth(bounds: bounds))
                            // This ZIndex Helps correct the Layout of cards showing on top of others during animation
                            .zIndex(self.store.courses[index].show ? 0 : 1)
                        }
                    }
                }
    
        }
        .disabled(self.active && !self.isScrollable ? true : false)
        
        }
    }
}

// Add Function to make angle of images less sharp on ipad

func getAngleMulitplier(bounds: GeometryProxy) -> Double {
    if bounds.size.width > 500 {
        return 80
    } else {
        
        return 20
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false), viewState: .constant(.zero)).environmentObject(UserStore())
    }
}

struct SectionView: View {
    @ObservedObject var store = CourseStore()
    var index: Int
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275
  
    
    var body: some View {
   
        VStack {
            VStack {
                   
                    HStack(alignment: .top) {
                        Text(section.title)
                            .font(.system(size: 24, weight: .bold))
                            .frame(width: 225, alignment: .leading)
                            .frame(height: 100)
                            .padding(.top, 35)
                            .foregroundColor(.white)
                        Spacer()
                    //    Image(uiImage: section.logo)
                        
                    }
                    section.text
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 75)
                    
                }
            

        
        ZStack(alignment: .bottom) {
            
                WebImage(url: section.image)
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

struct SectionSecondRowView: View {
    @ObservedObject var store = CourseStore()
    var index: Int
    var section: SectionSecondRow
    var width: CGFloat = 275
    var height: CGFloat = 275
  
    
    var body: some View {
   
        VStack {
            VStack {
                   
                    HStack(alignment: .top) {
                        Text(section.title)
                            .font(.system(size: 24, weight: .bold))
                            .frame(width: 225, alignment: .leading)
                            .frame(height: 100)
                            .padding(.top, 35)
                            .foregroundColor(.white)
                        Spacer()
                    //    Image(uiImage: section.logo)
                        
                    }
                    section.text
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 75)
                    
                }
            

        
        ZStack(alignment: .bottom) {
            
                WebImage(url: section.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 125)
                   //.padding(.bottom, 20)
                   //.blendMode(.darken)
                }
                
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(Color(#colorLiteral(red: 0.1078877077, green: 0.5771551132, blue: 0.8123810887, alpha: 1)))
        .cornerRadius(30)
        .shadow(color: Color(#colorLiteral(red: 0.1078877077, green: 0.5771551132, blue: 0.8123810887, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
      
        
    }
}

struct SectionThirdRowView: View {
    @ObservedObject var store = CourseStore()
    var index: Int
    var section: SectionThirdRow
    var width: CGFloat = 275
    var height: CGFloat = 275
  
    
    var body: some View {
   
        VStack {
            VStack {
                   
                    HStack(alignment: .top) {
                        Text(section.title)
                            .font(.system(size: 24, weight: .bold))
                            .frame(width: 225, alignment: .leading)
                            .frame(height: 100)
                            .padding(.top, 35)
                            .foregroundColor(.white)
                        Spacer()
                    //    Image(uiImage: section.logo)
                        
                    }
                    section.text
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 75)
                    
                }
            

        
        ZStack(alignment: .bottom) {
            
                WebImage(url: section.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 115)
                   //.padding(.bottom, 20)
                   //.blendMode(.darken)
                }
                
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(Color(#colorLiteral(red: 0.02357872203, green: 0.7047228813, blue: 0.6173975468, alpha: 1)))
        .cornerRadius(30)
        .shadow(color: Color(#colorLiteral(red: 0.02357872203, green: 0.7047228813, blue: 0.6173975468, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
      
        
    }
}
struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: Text
    var image: URL
    var logo: UIImage
    var color: UIColor
    
    
}

struct SectionSecondRow: Identifiable {
    var id = UUID()
    var title: String
    var text: Text
    var image: URL
    var logo: UIImage
    var color: UIColor
    
    
}

struct SectionThirdRow: Identifiable {
    var id = UUID()
    var title: String
    var text: Text
    var image: URL
    var logo: UIImage
    var color: UIColor
    
    
}



let sectionData = [
    Section(title: "", text: Text(""), image: URL(string: "https://dl.dropbox.com/s/plbdsvq889yyc4v/Card2%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)),
 
    
]

let sectionRowTwoData = [

    SectionSecondRow(title: "", text: Text(""), image: URL(string: "https://dl.dropbox.com/s/plbdsvq889yyc4v/Card2%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))


]

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
