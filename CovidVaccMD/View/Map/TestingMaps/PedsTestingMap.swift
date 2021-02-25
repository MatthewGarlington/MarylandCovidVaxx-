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
   
    var body: some View {
        
        ZStack(alignment: .top) {
            
        
            
            
            VStack {
                PedsTestingMapView(annotations: $annotations, pinsPedsTesting: $pinsPedsTesting, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)
                    
                    .alert(isPresented: $showingPlaceDetails) {
                        
                        
                        Alert(title: Text(selectedPlace?.title ?? ""), message: Text(selectedPlace?.subtitle ?? ""))
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
                    
                    
                
             
                VStack {
                    Text("Pediatrics")
                    .bold()
                    Text("Testing Locations")
                        .bold()
                    
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
