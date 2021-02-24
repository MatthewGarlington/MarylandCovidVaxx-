//
//  MapViewWithAnnotations.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/24/21.
//

import SwiftUI
import MapKit

struct MapViewWithAnnotations: View {
    
    @ObservedObject var localHealthVaccineLocations = LocalHealthVaccineLocationsModel()
    @ObservedObject var massVaccinationsitesViewModel = MassVaccinationViewModel()
    @State var annotations = [MKPointAnnotation]()
    @State var pinsLocalHealthArray = [MKPointAnnotation]()
    @State var pinsMassArray = [MKPointAnnotation]()
    @State var pinsRetailArray = [MKPointAnnotation]()
    @State var pinsHospitalArray = [MKPointAnnotation]()
    @State var showingPlaceDetails = false
    @State var showingEditScreen = false
    @State var selectedPlace: MKPointAnnotation?
    var body: some View {
        
   ZStack(alignment: .bottom) {
       
       Color("background2")
           .edgesIgnoringSafeArea(.all)
       
       VStack {
           
           Spacer()
                   
           VStack {
               Rectangle()
                           .frame(width: 75, height: 5)
                           .cornerRadius(3)
                           .opacity(0.1)
                   .padding()
           
                   Spacer()
                     
            MapViewMaryland(annotations: $annotations, pinsLocalHealthArray: $pinsLocalHealthArray, pinsHospitalArray: $pinsHospitalArray, pinsMassArray: $pinsMassArray, pinsRetailArray: $pinsRetailArray, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)
                       
                       .frame(maxWidth: 712)
                       .frame(height: 750)
                       .cornerRadius(50)
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
