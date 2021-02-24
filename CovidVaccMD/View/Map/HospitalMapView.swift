//
//  HospitalMapView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/24/21.
//

import SwiftUI
import MapKit

struct HospitalMapView: View {
    @State var annotations = [MKPointAnnotation]()
    @State var pinsHospitalArray = [MKPointAnnotation]()
    @State var showingPlaceDetails = false
    @State var selectedPlace: MKPointAnnotation?
    var body: some View {
        
   ZStack(alignment: .bottom) {

       
       VStack {
           
           Spacer()
                   
           VStack {
     
                   Spacer()
                     
            HospitalMapViewMaryland(annotations: $annotations, pinsHospitalArray: $pinsHospitalArray, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)

                       .alert(isPresented: $showingPlaceDetails) {
               
               
                   Alert(title: Text(selectedPlace?.title ?? ""), message: Text(selectedPlace?.subtitle ?? ""))
                   }
           }
       }
   }
    }
}
struct HospitalMapView_Previews: PreviewProvider {
    static var previews: some View {
        HospitalMapView()
    }
}
