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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ObservedObject var store = CourseStore()
    @ObservedObject var viewModel = TotalVaccineDataViewModel()
    
    @Binding var showProfile: Bool
    @Binding var showContent: Bool
    @Binding var viewState: CGSize

    @State var showUpdate = false
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @State var isScrollable = false
    @State var annotations = [MKPointAnnotation]()
    @State var pinsArray = [MKPointAnnotation]()
    @State var showingPlaceDetails = false
    @State var showingEditScreen = false
    @State var selectedPlace: MKPointAnnotation?
    @State var showCard = false
    @State var showCaseList = false
    @State var showFirstDoseList = false
    @State var showSecondDoseList = false
    @State var showOneShotList = false
    @State var show = false
    
    var body: some View {
        GeometryReader { bounds in
            ScrollView {
                VStack {
                    HStack {
                        Text("Maryland Vaccination")
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
                            MapTabView()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.leading, 14)
                    .padding(.top, 30)

                    ScrollView(.horizontal, showsIndicators: false) {
                        VaccinePercentHeaderView()
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

                    VStack {
                        HStack {
                            Text("All Doses")
                                .font(.title)
                                .bold()
                            Spacer()
                        }
                        .padding(.leading, 30)
                        .offset(y: -40)
                        .blur(radius: self.active ? 20 : 0)
                        .padding(.bottom, 0)

                        Spacer()
                        
                        VStack(spacing: 0) {
                            ScrollView(.horizontal, showsIndicators: false) {

                                HStack(spacing: 20) {
                                    // This gives the top SecitonView the ability to link to Contentful
                                    ForEach(viewModel.sections.indices, id: \.self) { index in
                                        GeometryReader { geometry in
                                            
                                            SectionView(index: index, section: self.viewModel.sections[index], width: 275, height: 275, showCaseList: $showCaseList)

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
                                }
                                .padding(.leading, 30)
                                .offset(y: -40)
                                .blur(radius: self.active ? 20 : 0)
                                .padding(.bottom, 0)


                                Spacer()
                                
                                VStack(spacing: 0) {
                                    ScrollView(.horizontal, showsIndicators: false) {

                                        HStack(spacing: 20) {
                                            // This gives the top SecitonView the ability to link to Contentful
                                            ForEach(viewModel.sectionsRowTwo.indices, id: \.self) { index in
                                                GeometryReader { geometry in
                                                    SectionSecondRowView(index: index, section: self.viewModel.sectionsRowTwo[index], width: 275, height: 275, showFirstDoseList: $showFirstDoseList)
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
                                }
                                .padding(.leading, 30)
                                .offset(y: -40)
                                .blur(radius: self.active ? 20 : 0)
                                .padding(.bottom, 0)


                                Spacer()
                                
                                VStack(spacing: 0) {
                                    ScrollView(.horizontal, showsIndicators: false) {

                                        HStack(spacing: 20) {
                                            // This gives the top SecitonView the ability to link to Contentful
                                            ForEach(viewModel.sectionsRowThree.indices, id: \.self) { index in
                                                GeometryReader { geometry in
                                                    SectionThirdRowView(index: index, section: self.viewModel.sectionsRowThree[index], width: 275, height: 275, showSecondDoseList: $showSecondDoseList)
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
                                    Text("Single Dose")
                                        .font(.title)
                                        .bold()
                                    Spacer()
                                }
                                .padding(.leading, 30)
                                .offset(y: -40)
                                .blur(radius: self.active ? 20 : 0)
                                .padding(.bottom, 0)

                                Spacer()

                                VStack(spacing: 0) {
                                    ScrollView(.horizontal, showsIndicators: false) {

                                        HStack(spacing: 20) {
                                            // This gives the top SecitonView the ability to link to Contentful
                                            ForEach(viewModel.sectionFourthRow.indices, id: \.self) { index in
                                                GeometryReader { geometry in
                                                    SectionFourthRowView(index: index, section: self.viewModel.sectionFourthRow[index],
                                                                         width: 275, height: 275,
                                                                         showOneShotList: $showOneShotList)

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
        
        .blur(radius: showCaseList ? 5 : 0)
        .blur(radius: showFirstDoseList ? 5 : 0)
        .blur(radius: showSecondDoseList ? 5 : 0)
        .blur(radius: showOneShotList ? 5 : 0)
        

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

                    AllDosesList()


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


        

        if showFirstDoseList {
            ZStack {
                ZStack {
                    Spacer()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white.opacity(0.1))
                        .onTapGesture {
                            withAnimation {
                                self.showFirstDoseList = false

                            }
                        }

                    FirstDoseList()

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
                        self.showFirstDoseList = false
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
                                self.showFirstDoseList = false

                            }
                        }

                        self.activeView = .zero
                    }
                )
            }
            .transition(.scale)
        }
        
        
        if showSecondDoseList {


            
            ZStack {
                ZStack {

                    
                    Spacer()

                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white.opacity(0.1))
                        .onTapGesture {
                            withAnimation {
                                self.showSecondDoseList = false

                            }
                        }

                    SecondDoseList()


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
                        self.showSecondDoseList = false
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
                                self.showSecondDoseList = false
                            }
                        }

                        self.activeView = .zero
                    }
                )
            }
            .transition(.scale)
        }

        if showOneShotList {
            ZStack {
                ZStack {
                    Spacer()

                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white.opacity(0.1))
                        .onTapGesture {
                            withAnimation {
                                self.showOneShotList = false

                            }
                        }

                    SingleShotDoseList()


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
                        self.showOneShotList = false
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
                                self.showOneShotList = false
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

// Add Function to make angle of images less sharp on ipad

func getAngleMulitplier(bounds: GeometryProxy) -> Double {
    if bounds.size.width > 500 {
        return 80
    } else {
        return 20
    }
}

let sectionData = [
    Section(title: "", text: Text(""), image: URL(string: "https://dl.dropbox.com/s/plbdsvq889yyc4v/Card2%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)),

    
]

let sectionRowTwoData = [

    SectionSecondRow(title: "", text: Text(""), image: URL(string: "https://dl.dropbox.com/s/plbdsvq889yyc4v/Card2%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))


]


