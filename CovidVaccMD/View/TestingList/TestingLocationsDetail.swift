//
//  TestingLocationsDetail.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/25/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct TestingLocationsDetail: View {
    var update: Update = updateData[0]
    var testing: TestingLocationsFeatures = testingeData
    @State var show = false
    @State var viewState = CGSize.zero
    @State var isDragging = false
 
    
    
    var body: some View {
        
        
        ScrollView {
        ZStack {
            
            
            Spacer()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("background2"))
                .ignoresSafeArea(.all)
      
            
                VStack {
            
     
                    VStack {

                        Text("\(testing.attributes?.name ?? "")")
                            .font(.title)
                            .fontWeight(.heavy)
                            .frame(maxWidth: 400, maxHeight: 125)
                            .foregroundColor(.white)
                            .background(BlurView(style: .systemThickMaterialDark))
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .offset(y: 75)


                        
                        VStack {
                            WebImage(url: update.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 250)
                                    .blendMode(.overlay)
                                    .offset(y: -100)
                            WebImage(url: update.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 200)
                                    .blendMode(.overlay)
                                    .offset(y: 55)
                            WebImage(url: update.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: .infinity)
                                    .blendMode(.overlay)
                                    .offset(y: 75)
                                        
                            ZStack {
                                
                                VStack(alignment: .leading, spacing: 20) {
                            
                                
                                VStack(alignment: .leading, spacing: 20) {
                        
                                    
                                    Text("\(testing.attributes?.municipality ?? "")")
                                        .font(.system(size: 20, weight: .bold))
                                        
                                    Text("\(testing.attributes?.fulladdr ?? "")")
                                        .lineLimit(2)
                                        .font(.subheadline)
                                 
                                    Text("\(testing.attributes?.operationalhours ?? "")")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.secondary)
                              
                                    
                                    
                                    HStack {
                                    
                                        Text("Email Contact:")
                                            .bold()
                                        
                                        
                                        Text("\(testing.attributes?.scheduling_contact_email ?? "No Email for Scheduling")")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.secondary)
                                        
                                        
                                    }
                                    
                                    HStack {
                                    
                                        Text("Site Info:")
                                            .bold()
                                        
                                        
                                    Text("\(testing.attributes?.cost_notes ?? "No Notes On This Site")")
                                            .font(.callout)
                                            .fontWeight(.bold)
                                            .foregroundColor(.secondary)
                                        
                                        
                                    }
                                  
                                
                                    HStack {
                                        Text("Contact Phone Number:")
                                            .fontWeight(.bold)
                                            
                                        Text("\(testing.attributes?.scheduling_contact_phone ?? "No Phone Number For Scheduling")")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    HStack {
                                        
                                        Text("Scheduling URL:")
                                            .fontWeight(.bold)
                                        
                                        Link("\(testing.attributes?.schedule_url ?? "")",
                                             destination: (URL(string: "\(testing.attributes?.schedule_url ?? "https://developer.apple.com/documentation/swiftui/link")") ?? URL(string: "https://developer.apple.com/documentation/swiftui/link"))!)
                                        
                                    }
                                    
                                    HStack {
                                        Text("Active?")
                                            .fontWeight(.bold)
                                            
                                        Text("\(testing.attributes?.ActiveYesNo ?? "")")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            VStack(alignment: .leading, spacing: 20) {
                                    HStack {
                                        Text("Doctor's Order required?")
                                            .fontWeight(.bold)
                                            
                                        Text("\(testing.attributes?.docorder_required ?? "")")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    HStack {
                                        Text("Other Notes:")
                                            .fontWeight(.bold)
                                            
                                        Text("\(testing.attributes?.other_notes ?? "")")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    HStack {
                                        Text("Accepts Medicaid?")
                                            .fontWeight(.bold)
                                            
                                        Text("\(testing.attributes?.medicaid ?? "")")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.secondary)
                                    }
                                      
                                
                                    
                                }
                            }
                                .padding()
                                .frame(width: 360, height: 600)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .background(BlurView(style: .systemThickMaterial))
                                .cornerRadius(15)
                                .frame(maxWidth: .infinity)
                                .frame(height: 75)
                                .shadow(color: Color("background2").opacity(0.2), radius: 10, x: 10, y: 10)
                                .shadow(color: Color("background2").opacity(0.7), radius: 10, x: -5, y: -5)
                                .offset(y: -375)
                              
                                .background(
                                    
                                    Spacer()
                                .frame(width: 400, height: 650)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .shadow(color: Color("background2"), radius: 20, x: 20, y: 20)
                                .shadow(color: Color("background2"), radius: 20, x: -20, y: -20)
                                .background(BlurView(style: .systemUltraThinMaterialLight))
                                .cornerRadius(15)
                                .frame(maxWidth: .infinity)
                                .frame(height: 75)
                                .offset(y: -375)
                                    
                                    
                                
                            )
                                
                                Spacer()
                          
                              
                            }
                        }
                    }
                    
                    .background(
                                ZStack {
                                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                                        .offset(x: -150, y: -200)
                                        // Added Rotation for the blob
                                        .rotationEffect(Angle(degrees:  show ? 360 : 90))
                                        .blendMode(.plusDarker)
                                        // Animation Rotates
                                        .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
                                        // Triggers the the show varible upon the blob appearing
                                        .onAppear { self.show = true }
                    
                                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                                        .offset(x: -200, y: -250)
                                        .rotationEffect(Angle(degrees:  show ? 360 : 0), anchor: .leading)
                                        .blendMode(.overlay)
                                        .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
                                }
                    
                            )
//                            .background(WebImage(url: update.image))
//                            .offset(x: viewState.width / 100, y: viewState.height / 100)
                            .background(Color(#colorLiteral(red: 0.1944684982, green: 0.7717260122, blue: 1, alpha: 1)))
                            .frame(height: 800)
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .scaleEffect(isDragging ? 0.9 : 1 )
                            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                            .rotation3DEffect(
                                Angle(degrees: 5),
                                axis: (x: viewState.width, y: viewState.height, z: 0.0))
                             
          
                }
            
                
            }
        }
    
                
        }
}

struct TestingLocationsDetail_Previews: PreviewProvider {
    static var previews: some View {
        TestingLocationsDetail()
    }
}
