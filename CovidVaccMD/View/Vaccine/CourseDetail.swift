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
                                .font(.system(size: 24, weight: .bold))
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
                
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Vaccine supply is dependent on the federal government’s allocation to Maryland and is subject to change. Please note that population groups are non-exhaustive and all numbers are approximate.")
                    
                    Text("PHASE 1A")
                        .font(.title)
                        .bold()

                   
                            Text("WHO:")
                                .font(.title2)
                                .bold()
        
                       
                            
                            Text("A​ll licensed, registered, and certified healthcare providers; nursing home residents and staff; law enforcement, and firefighters, EMS, and other first responders; correctional healthcare staff and officers; and front line judiciary staff.")
               
           
             
                        Text("WHEN:")
                            .font(.title2)
                            .bold()
                        
                        Text("Phase 1A began in mid-late December.")
                    
                }
                
                .padding(30)
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("PHASE 1B")
                        .font(.title)
                        .bold()

                   
                            Text("WHO:")
                                .font(.title2)
                                .bold()
        
                       
                            
                            Text("Maryland residents who are 75 years and older; Marylanders in assisted living, independent living, developmental disabilities/behavioral health group homes, and other congregate facilities; high-risk incarcerated individuals; continuity of government vaccinations; and education, including K-12 teachers, support staff, and child care providers.")
               
           
             
                        Text("WHEN:")
                            .font(.title2)
                            .bold()
                        
                        Text("The state plans to officially enter Phase 1B on January 18.")
                    
                }
                .padding(30)
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("PHASE 1C")
                        .font(.title)
                        .bold()

                   
                            Text("WHO:")
                                .font(.title2)
                                .bold()
        
                       
                            
                            Text("Adults age 65-74; public health and safety workers not covered in Phase 1A; and essential workers in lab services, food/agriculture production, manufacturing, the U.S. Postal Service, public transit, and grocery stores.")
               
           
             
                        Text("WHEN:")
                            .font(.title2)
                            .bold()
                        
                        Text("T​he state plans to officially enter Phase 1C on January 25.")
                    
                }
                .padding(30)
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("PHASE 2")
                        .font(.title)
                        .bold()

                   
                            Text("WHO:")
                                .font(.title2)
                                .bold()
        
                       
                            
                            Text("A​dults 16-64 at increased risk of severe COVID-19 illness due to comorbidities; essential workers in critical utilities, transportation, logistics, infrastructure, food service, etc; and incarcerated adults. A​pproximately 1.1 million individuals.")
               
           
             
                        Text("WHEN:")
                            .font(.title2)
                            .bold()
                        
                        Text("​Phase 2 may begin after the majority of Phase 1 has been vaccinated, or the federal government’s allocation of vaccines increases.")
                    
                }
                .padding(30)
                
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("PHASE 3")
                        .font(.title)
                        .bold()

                   
                            Text("WHO:")
                                .font(.title2)
                                .bold()
        
                       
                            
                            Text("G​eneral population, including healthy adults ages 16-64. A​pproximately 4 million individuals")
               
           
             
                        Text("WHEN:")
                            .font(.title2)
                            .bold()
                        
                        Text("​Phase 3 will begin once the majority of Phase 2 has been vaccinated and/or the federal government’s allocation of vaccines increases.")
                    
                }
                .padding(30)
                .padding(.bottom, 100)
            }
         
        }
        
        
       
    }
}

struct CourseDetail_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { bounds in
            CourseDetail(course: courseData[0], show: .constant(true), active: .constant(true), activeIndex: .constant(-1), isScrollable: .constant(true), bounds: bounds)
        }
    }
}





