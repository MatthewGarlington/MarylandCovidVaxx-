//
//  CourseDetail.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//
import SwiftUI
import SDWebImageSwiftUI

struct CourseDetail: View {
    var course: Course
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    @Binding var isScrollable: Bool
    var bounds: GeometryProxy
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                VStack {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text(course.title)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(Color.white)
                            Text(course.subtitle)
                                .foregroundColor(Color.white.opacity(0.7))
                        }
                        Spacer()
                        ZStack {
                 
                            
                            VStack {
                                Image(systemName: "xmark")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36)
                            .background(Color.black)
                            .clipShape(Circle())
                            .onTapGesture {
                                self.show = false
                                self.active = false
                                self.activeIndex = -1
                                self.isScrollable = false
                            }
                        }
                    }
                    Spacer()
                    WebImage(url: course.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: 140, alignment: .top)
                }
                .padding(show ? 30 : 20)
                .padding(show ? 30 : 0)
//                .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 :  CGFloat(280))
                //
                .frame(maxWidth: show ? .infinity : bounds.size.width - 60)
                .frame(height: show ? 460 : 280)
                .background(Color(course.color))
                .clipShape(RoundedRectangle(cornerRadius: getCardCornerRadius(bounds: bounds), style: .continuous))
                .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 20)
                
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("Take your SwiftUI app to the App Store with advanced techniques like API data, packages, and CMS")
                    
                    Text("About this course")
                        .font(.title)
                        .bold()

                    Text("This course is unlike any other. WE care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for ios and MacOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible consistency and performance. It's a beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions")

                    Text("Minimal coding experience required, such as in HTML and CSS. Please note that Xcode 11 and Catalina are essential. Once you get everything installed, it'll get a lot friendlier! I added a bunch of troubleshoots at the end of this page to help you navigate the issues you might encounter.")
                    
                }
                .padding(30)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct CourseDetail_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { bounds in
            CourseDetail(course: courseData[0], show: .constant(true), active: .constant(true), activeIndex: .constant(-1), isScrollable: .constant(true), bounds: bounds)
        }
    }
}

