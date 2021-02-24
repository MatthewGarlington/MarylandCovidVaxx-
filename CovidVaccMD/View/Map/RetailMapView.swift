//
//  RetailMapView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/24/21.
//

import SwiftUI
import MapKit

struct RetailMapView: View {
    @State var annotations = [MKPointAnnotation]()
    @State var pinsRetailArray = [MKPointAnnotation]()
    @State var showingPlaceDetails = false
    @State var selectedPlace: MKPointAnnotation?
    var body: some View {
        
   ZStack(alignment: .bottom) {

       
       VStack {
           
           Spacer()
                   
           VStack {
     
                   Spacer()
                     
            RetailMapViewMaryland(annotations: $annotations, pinsRetailArray: $pinsRetailArray, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)

                       .alert(isPresented: $showingPlaceDetails) {
               
               
                   Alert(title: Text(selectedPlace?.title ?? ""), message: Text(selectedPlace?.subtitle ?? ""))
                   }
           }
       }
   }
    }
}

struct RetailMapView_Previews: PreviewProvider {
    static var previews: some View {
        RetailMapView()
    }
}
