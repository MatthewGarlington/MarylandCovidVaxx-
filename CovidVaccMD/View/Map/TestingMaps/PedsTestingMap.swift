//
//  PedsTestingMap.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/25/21.
//

import SwiftUI
import MapKit

struct PedsTestingMap: View {
    @State var annotations = [MKPointAnnotation]()
    @State var pinsPedsTesting = [MKPointAnnotation]()
    @State var showingPlaceDetails = false
    @State var selectedPlace: MKPointAnnotation?
    @State var showTestingList = false
    @State private var showUserLocation = false
   
    var body: some View {
        
        ZStack(alignment: .top) {
            
        
            
            
            VStack {
                if showUserLocation {
                    
                    PedsTestingMapViewWithUserLocation(annotations: $annotations, pinsPedsTesting: $pinsPedsTesting, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)
                        
                        .alert(isPresented: $showingPlaceDetails) {
                            
                            
                            Alert(title: Text(selectedPlace?.title ?? ""), message: Text(selectedPlace?.subtitle ?? ""))
                    }
             
                } else {
                    
                    PedsTestingMapView(annotations: $annotations, pinsPedsTesting: $pinsPedsTesting, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)
                        
                        .alert(isPresented: $showingPlaceDetails) {
                            
                            
                            Alert(title: Text(selectedPlace?.title ?? ""), message: Text(selectedPlace?.subtitle ?? ""))
                    }
                }
                
            }
            
            ZStack {
                
                BlurView(style: .systemThickMaterial)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(15)
                    .frame(height: 75)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 12)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    .padding()
                    
                    
                HStack {
                    
                    VStack {
                        
                        Toggle("", isOn: $showUserLocation.animation(.interactiveSpring(response: 2, dampingFraction: 0.5, blendDuration: 0.5)))
                            .toggleStyle(SwitchToggleStyle(tint: .red))
                        
                    }
                    .frame(width: 50)
                    .offset(x: -50)
             
                VStack {
                    Text("Pediatrics")
                    .bold()
                    Text("Testing Locations")
                        .bold()
                    
                }
                    
                    Button(action: {self.showTestingList.toggle()}) {
                        Image(systemName: "list.bullet")
                            .foregroundColor(Color.red)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color("background3"))
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                            
                        
                    }.offset(x: 30)
                    .sheet(isPresented: $showTestingList) {
                        
                        PedsTestingLocationList()
                  
                    }
                    
                    
                }
                    
               
            }
         
        }
    }
}


struct PedsTestingMap_Previews: PreviewProvider {
    static var previews: some View {
        PedsTestingMap()
    }
}
