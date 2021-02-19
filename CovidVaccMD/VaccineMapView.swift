//
//  VaccineMapView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/19/21.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct MapViewMarylandAnnot: View {
    

    
    @ObservedObject var vm = VaccineLocationsModel()
    
    @State private var annotations = [MKPointAnnotation]()
    @State private var pinsArray = [MKPointAnnotation]()
    @State private var centerCoordinate = CLLocationCoordinate2D()
//    @State private var locations = [CodableMKPointAnnotation]()
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    @State private var selectedPlace: MKPointAnnotation?
    
   
   
    var body: some View {
        
        
   
    
        ZStack {
            
          
                
            MapViewMaryland(annotations: $annotations, pinsArray: $pinsArray, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, centerCoordinate: $centerCoordinate)
                    .edgesIgnoringSafeArea(.all)
                    
                
                
            
                
        
  
            
            
        }.alert(isPresented: $showingPlaceDetails) {
        
        
            Alert(title: Text(selectedPlace?.title ?? ""), message: Text(selectedPlace?.subtitle ?? ""))
        }
        
            
    }
    }
    


struct MapViewMarylandAnnot_Previews: PreviewProvider {
    static var previews: some View {
        MapViewMarylandAnnot()
    }
}
