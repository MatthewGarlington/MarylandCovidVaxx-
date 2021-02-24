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
        
   ZStack(alignment: .top) {


                     
            RetailMapViewMaryland(annotations: $annotations, pinsRetailArray: $pinsRetailArray, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)

                       .alert(isPresented: $showingPlaceDetails) {
               
               
                   Alert(title: Text(selectedPlace?.title ?? ""), message: Text(selectedPlace?.subtitle ?? ""))
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
           
            Text("Retail Store")
                .bold()
            
            
            Text("Vaccination Locations")
                .bold()
           
                
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
