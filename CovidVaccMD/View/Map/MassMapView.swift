//
//  MassMapView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/24/21.
//

import SwiftUI
import MapKit

struct MassMapView: View {
    @State var annotations = [MKPointAnnotation]()
    @State var pinsMassArray = [MKPointAnnotation]()
    @State var showingPlaceDetails = false
    @State var selectedPlace: MKPointAnnotation?
    var body: some View {
        
   ZStack(alignment: .bottom) {

       
       VStack {
           
           Spacer()
                   
           VStack {
     
                   Spacer()
                     
            MassMapViewMaryland(annotations: $annotations, pinsMassArray: $pinsMassArray, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)

                       .alert(isPresented: $showingPlaceDetails) {
               
               
                   Alert(title: Text(selectedPlace?.title ?? ""), message: Text(selectedPlace?.subtitle ?? ""))
                   }
           }
       }
   }
    }
}

struct MassMapView_Previews: PreviewProvider {
    static var previews: some View {
        MassMapView()
    }
}
