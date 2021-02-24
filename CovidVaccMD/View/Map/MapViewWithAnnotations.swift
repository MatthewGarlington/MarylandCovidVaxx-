//
//  MapViewWithAnnotations.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/24/21.
//

import SwiftUI
import MapKit

struct MapViewWithAnnotations: View {
    

    @State var annotations = [MKPointAnnotation]()
    @State var pinsLocalHealthArray = [MKPointAnnotation]()
    @State var pinsMassArray = [MKPointAnnotation]()
    @State var pinsRetailArray = [MKPointAnnotation]()
    @State var pinsHospitalArray = [MKPointAnnotation]()
    @State var showingPlaceDetails = false
    @State var selectedPlace: MKPointAnnotation?
    var body: some View {
        
        ZStack(alignment: .top) {
            
        
            
            
            VStack {
                MapViewMaryland(annotations: $annotations, pinsLocalHealthArray: $pinsLocalHealthArray, pinsHospitalArray: $pinsHospitalArray, pinsMassArray: $pinsMassArray, pinsRetailArray: $pinsRetailArray, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)
                    
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
                    
                    
                    
                    
                
                Text("All Vaccine Locations")
                    .bold()
            }
         
        }
    }
}

struct MapViewWithAnnotations_Previews: PreviewProvider {
    static var previews: some View {
        MapViewWithAnnotations()
    }
}
