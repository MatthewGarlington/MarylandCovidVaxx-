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
        
   ZStack(alignment: .bottom) {
       

       VStack {
           
           Spacer()
                   
           VStack {
    
           
                   Spacer()
                     
            MapViewMaryland(annotations: $annotations, pinsLocalHealthArray: $pinsLocalHealthArray, pinsHospitalArray: $pinsHospitalArray, pinsMassArray: $pinsMassArray, pinsRetailArray: $pinsRetailArray, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)
        
                       .alert(isPresented: $showingPlaceDetails) {
               
               
                   Alert(title: Text(selectedPlace?.title ?? ""), message: Text(selectedPlace?.subtitle ?? ""))
                   }
           }
       }
   }
    }
}

struct MapViewWithAnnotations_Previews: PreviewProvider {
    static var previews: some View {
        MapViewWithAnnotations()
    }
}
