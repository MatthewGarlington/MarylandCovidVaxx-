//
//  LocalHealthMapView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/24/21.
//

import SwiftUI
import MapKit

struct LocalHealthMapView: View {
    @State var annotations = [MKPointAnnotation]()
    @State var pinsLocalHealthArray = [MKPointAnnotation]()
    @State var showingPlaceDetails = false
    @State var selectedPlace: MKPointAnnotation?
    var body: some View {
        
   ZStack(alignment: .bottom) {

       
       VStack {
           
           Spacer()
                   
           VStack {
     
                   Spacer()
                     
            LocalHealthMapViewMaryland(annotations: $annotations, pinsLocalHealthArray: $pinsLocalHealthArray, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)

                       .alert(isPresented: $showingPlaceDetails) {
               
               
                   Alert(title: Text(selectedPlace?.title ?? ""), message: Text(selectedPlace?.subtitle ?? ""))
                   }
           }
       }
   }
    }
}
struct LocalHealthMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocalHealthMapView()
    }
}
