//
//  VaccineMapView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/19/21.
//

import SwiftUI
import MapKit
//import LocalAuthentication

struct MapViewMarylandAnnot: View {
    

    
    @ObservedObject var vm = VaccineLocationsModel()
    @State var annotations = [MKPointAnnotation]()
    @State var pinsArray = [MKPointAnnotation]()
  //  @State var centerCoordinate = CLLocationCoordinate2D()
    @State var showingPlaceDetails = false
    @State var showingEditScreen = false
    @State var selectedPlace: MKPointAnnotation?
    @State var region = MKCoordinateRegion()

    
    
   
   
    var body: some View {
        
 
   
    
        VStack {
            ZStack {
                
              
                    
                MapViewMaryland(annotations: $annotations, pinsArray: $pinsArray, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)
                    
       
            }.alert(isPresented: $showingPlaceDetails) {
            
            
                Alert(title: Text(selectedPlace?.title ?? ""), message: Text(selectedPlace?.subtitle ?? ""))
        }
        }
        
            
    }
    }
    


struct MapViewMarylandAnnot_Previews: PreviewProvider {
    static var previews: some View {
        MapViewMarylandAnnot()
    }
}
