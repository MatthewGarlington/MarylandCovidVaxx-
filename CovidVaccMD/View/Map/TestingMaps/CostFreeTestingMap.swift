//
//  CostFreeTestingMap.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/25/21.
//

import SwiftUI
import MapKit

struct CostFreeTestingMap: View {
    @State var annotations = [MKPointAnnotation]()
    @State var pinsCostFreeTesting = [MKPointAnnotation]()
    @State var showingPlaceDetails = false
    @State var selectedPlace: MKPointAnnotation?
    @State var showTestingList = false
   
    var body: some View {
        
        ZStack(alignment: .top) {
            
        
            
            
            VStack {
                CostFreeTestingView(annotations: $annotations, pinsCostFreeTesting: $pinsCostFreeTesting, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)
                    
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
                    
                    
                
                HStack {
                
                Text("Cost Free Testing Locations")
                    .bold()
                    
                    Button(action: {self.showTestingList.toggle()}) {
                        Image(systemName: "list.bullet")
                            .foregroundColor(Color.red)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color("background3"))
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                            
                        
                    }.offset(x: 40)
                    .sheet(isPresented: $showTestingList) {
                        
                        NoCostTestingList()
                  
                    }
                    
                }
            }
         
        }
    }
}

struct CostFreeTestingMap_Previews: PreviewProvider {
    static var previews: some View {
        CostFreeTestingMap()
    }
}
