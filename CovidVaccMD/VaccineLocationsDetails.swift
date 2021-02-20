//
//  VaccineLocationsDetails.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/20/21.
//

import SwiftUI

struct VaccineLocationsDetails: View {
    var update: Update = updateData[0]
    var vaccine: VaccineLocationsFeatures = vaccineData
    @State var show = false
    @State var viewState = CGSize.zero
    @State var isDragging = false
 
    
    
    var body: some View {
        
        
        
        ZStack {
            
            
            Spacer()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("background2"))
                .ignoresSafeArea(.all)
            ScrollView {
            
                VStack {
            
     
                    VStack {
                        
                        Text("\(vaccine.attributes?.name ?? "")")
                            .font(.title)
                            .bold()
                            .padding(.top, 30)
                        
                        
                        
                  
                        
                        VStack {
                            
                                Image(update.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity)
                   
               
                            VStack(alignment: .leading, spacing: 12) {
                    
                                
                                Text("\(vaccine.attributes?.municipality ?? "")")
                                    .font(.system(size: 20, weight: .bold))
                                    
                                Text("\(vaccine.attributes?.fulladdr ?? "")")
                                    .lineLimit(2)
                                    .font(.subheadline)
                             
                                Text("\(vaccine.attributes?.operationalhours ?? "")")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                                
                                Text("Scheduling Website: \(vaccine.attributes?.website_url ?? "")")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                                Text("Email Contact: \(vaccine.attributes?.scheduling_contact_email ?? "No Email for Scheduling")")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                               
                                Text("Contact Phone Number: \(vaccine.attributes?.scheduling_contact_phone ?? "No Phone Number For Scheduling")")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 20, y: 20)
                                
                         
                                
                            }
                            .padding()
                            .frame(width: 400, height: 400)
                            .background(
                                ZStack {
                                    Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1))
                                    
                                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                                        .foregroundColor(Color(#colorLiteral(red: 0.8174115368, green: 0.8757289902, blue: 0.997786832, alpha: 1)))
                                        .blur(radius: 4)
                                        .offset(x: -8, y: -8)
                                    
                                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8174115368, green: 0.8757289902, blue: 0.997786832, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .padding(2)
                                        .blur(radius: 2)
                                }
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color(#colorLiteral(red: 0.8174115368, green: 0.8757289902, blue: 0.997786832, alpha: 1)), radius: 20, x: 20, y: 20)
                            .shadow(color: Color(#colorLiteral(red: 0.4119725525, green: 0.472499907, blue: 0.9727101922, alpha: 1)), radius: 20, x: -20, y: -20)
                            .background(Color(#colorLiteral(red: 0.8174115368, green: 0.8757289902, blue: 0.997786832, alpha: 1)))
                            .cornerRadius(15)
                            .offset(y: -200)
                          
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
                            .background(Image(uiImage: #imageLiteral(resourceName: "Card3"))
                                            .offset(x: viewState.width / 15, y: viewState.height / 15),
                                        alignment: .bottom)
                    
                            .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .scaleEffect(isDragging ? 0.9 : 1 )
                            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                            .rotation3DEffect(
                                Angle(degrees: 5),
                                axis: (x: viewState.width, y: viewState.height, z: 0.0))
                }
               
            }
            .listStyle(PlainListStyle())
        }
    }
}
   
struct VaccineLocationsDetails_Previews: PreviewProvider {
    static var previews: some View {
        VaccineLocationsDetails()
    }
}
