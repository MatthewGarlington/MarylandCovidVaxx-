//
//  CourseList.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CourseList: View {

    @ObservedObject var store = CourseStore()
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var isScrollable = false
    
    var body: some View {
        GeometryReader { bounds in
            ZStack {
                
                // Sets background to change colors upon full screen tap gesture
                
                Color.black.opacity(Double(self.activeView.height) / 500)
                    .animation(.linear)
                    .edgesIgnoringSafeArea(.all)
           
                ScrollView {
                    
                    
                    VStack(spacing: 30) {
                        Text("Courses")
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 30)
                            .padding(.top, 30)
                            // Blurs the top title upon hitting the tap gesture to active on selecting a card
                            .blur(radius: active ? 20 : 0)
                        
                        // Using the store before usees the observable object of the Contentful API and Combine instead of from our on array
                        VStack(spacing: 30) {
                            ForEach(store.courses.indices, id: \.self) { index in
                                GeometryReader { geometry in
                                    CourseView(
                                        show: self.$store.courses[index].show,
                                        active: self.$active,
                                        activeIndex: self.$activeIndex,
                                        course: self.store.courses[index],
                                        index: index,
                                        // Added the ability to change the color of the background upon dragging
                                        activeView: self.$activeView,
                                        bounds: bounds,
                                        isScrollable: self.$isScrollable)
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
                                .zIndex(self.store.courses[index].show ? 1 : 0)
                            }
                        }
 
                    }
                    .frame(width: bounds.size.width)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                    
                    // Upon gesture tap to the full view, the status bar will be hidden
                    .statusBar(hidden: active ? true : false)
                    .animation(.linear)
                    // Disable the ability for the scrolling and animation to not activate during the 0.7 Second delay
                    .disabled(self.active && !self.isScrollable ? true : false)
                }
            }
        }
   
    }
}

// This function gives tha ability a condition within another condition to display the correct screen size for full screen card view on a larger display

func getCardWidth(bounds: GeometryProxy) -> CGFloat {
    
    if bounds.size.width > 712 {
        return 712
        
    }
    
    return bounds.size.width - 60

}

 // This function allows the same ability to use within a condition but for the corner radius

func getCardCornerRadius(bounds: GeometryProxy) -> CGFloat {

    if bounds.size.width < 712 && bounds.safeAreaInsets.top < 44 {
        return 0
        
    }

    return 30

}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    var course: Course
    var index: Int
    @Binding var activeView: CGSize
    var bounds: GeometryProxy
    @Binding var isScrollable: Bool
   
    
    
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30) {
                Text("")
                
            }
            .animation(nil)
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : CGFloat(200), alignment: .top)
            .offset(y: show ? 460 : 0)
            .background(Color("background1"))
            .clipShape(RoundedRectangle(cornerRadius: show ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color.white)
                        Text(course.subtitle)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    Spacer()
                    ZStack {
                        Image(uiImage: course.logo)
                            .opacity(show ? 0 : 1)
                        
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0 )
                        .offset(x :2, y: -2)
                    }
                }
                Spacer()
                
                // Using the SDWebImage to display image
                WebImage(url: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(show ? 30 : 0)
            .frame(maxWidth: show ? .infinity : bounds.size.width - 60)
            .frame(height: show ? 460 :  CGFloat(280))
            .background(Color(course.color))
            .clipShape(RoundedRectangle(cornerRadius: getCardCornerRadius(bounds: bounds), style: .continuous))
            .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 20)
            
            // This gives the ability for the translation value on the drag gesture to be represented upon dragging
            .gesture(
                
                /// The Show condistional accompanied by the : nil at the end, give the ability for only the card to show the drag gesture upon selection
                show ?
                DragGesture().onChanged  { value in
                    
                    // This guard statement allows the full size card to be dismissed after dragging to a translation height of 300
                    guard value.translation.height < 300 else { return }
                    
                    // This guard statement lets the drag animations to not take place upon dragging up on the screen
                    
                    guard value.translation.height > 0 else { return }
                    
                    self.activeView = value.translation
                    
                }
                
                .onEnded { value in
            
                // This tells the full screen card view to close upon dragging to 50
                   if self.activeView.height > 50 {
                        
                        self.show = false
                        self.active = false
                        self.activeIndex = -1
                        self.isScrollable = false
                        
                    }
                    
                    self.activeView = .zero
                    
                    
                }
                : nil
            
            )
        
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                if self.show {
                    self.activeIndex = self.index
                } else {
                    
                    self.activeIndex = -1
                    
                }
                // This will delay the animation so the animation and scrollview do not come at that same time
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    
                    self.isScrollable = true
                }
            }
            
            if isScrollable {
                // When this is enabled, and the self.activeView = value.translation is disabled, there will not be gestures but will be able to present a scrollable detail view from CourseDetail and exited without gestures.
                
                CourseDetail(course: course, show: $show, active: $active, activeIndex: $activeIndex, isScrollable: $isScrollable, bounds: bounds)
                    .background(Color("background1"))
                    // This adds the corner radius to the CourseDetail view that is scrollable and adaptive to device
                    .clipShape(RoundedRectangle(cornerRadius: show ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
                    .animation(nil)
                    .transition(.identity)
                
            }
        }
     
        .frame(height: show ? bounds.size.height + bounds.safeAreaInsets.top
                + bounds.safeAreaInsets.bottom: 280)
        // The added scale effect is for the drag gesture of the animation
        .scaleEffect(1 - self.activeView.height / 1000)
        // This allows the cards to rotate upon the drag gesture to either side
        .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)),
            axis: (x: 0.0, y: 10.0, z: 0.0))
        .hueRotation(Angle(degrees: Double(self.activeView.height)))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        
        // By Placing this code in the ZStack Container as well it gives the ability for the user to drag on the text as well as the card therefore fixing the scrollview issue
        // This gives the ability for the translation value on the drag gesture to be represented upon dragging
        .gesture(
            
            /// The Show condistional accompanied by the : nil at the end, give the ability for only the card to show the drag gesture upon selection
            show ?
            DragGesture().onChanged  { value in
                
                // This guard statement allows the full size card to be dismissed after dragging to a translation height of 300
                guard value.translation.height < 300 else { return }
                
                // This guard statement lets the drag animations to not take place upon dragging up on the screen
                
                guard value.translation.height > 50 else { return }
                
                self.activeView = value.translation
                
            }
            
            .onEnded { value in
        
            // This tells the full screen card view to close upon dragging to 50
               if self.activeView.height > 50 {
                    
                    self.show = false
                    self.active = false
                    self.activeIndex = -1
                    self.isScrollable = false
                    
                }
                
                self.activeView = .zero
                
                
            }
            : nil
        
        )
        .disabled(active && !isScrollable ? true : false)
        .ignoresSafeArea(.all)
    }
}

struct Course: Identifiable {
    
    var id = UUID()
    var title: String
    var subtitle: String
    var image: URL
    var logo: UIImage
    var color: UIColor
    var show: Bool
    
}

var courseData = [
    Course(title: "Prototype Designs in SwiftUI", subtitle: "18 Sections", image: URL(string: "https://dl.dropbox.com/sh/hkloectchldtk38/AADZ7E4LkjPsRaz-SuiAMDHXa/URL%20Images/Card1%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
   Course(title: "SwiftUI Advanced", subtitle: "20 Sections", image: URL(string: "https://dl.dropbox.com/s/plbdsvq889yyc4v/Card2%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
   Course(title: "UI Design for Developers", subtitle: "20 Sections", image: URL(string: "https://dl.dropbox.com/s/9vvklb94vpaafxw/Card3%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo3"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), show: false)
]

