//
//  MapTabView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/24/21.
//

import SwiftUI

struct MapTabView: View {
    

    @State private var selection = 0
    
    var body: some View {
  
  
          
        ZStack(alignment: .topTrailing) {
        
                

        TabView(selection: $selection) {
            MapViewWithAnnotations().tabItem {
                selection == 0 ? Image(systemName: "mappin.circle.fill") : Image(systemName: "mappin.circle")
                Text("All")
                
            }
            .tag(0)
            RetailMapView().tabItem {
                selection == 1 ? Image(systemName: "mappin.circle.fill") : Image(systemName: "mappin.circle")
             
                Text("Retail")
                
            }
            .tag(1)
            MassMapView().tabItem {
                selection == 2 ? Image(systemName: "mappin.circle.fill") : Image(systemName: "mappin.circle")
              
                Text("Mass")
            }
            .tag(2)
            
            HospitalMapView().tabItem {
                selection == 3 ? Image(systemName: "mappin.circle.fill") : Image(systemName: "mappin.circle")
              
                Text("Hospital")
            }
            .tag(3)
            LocalHealthMapView().tabItem {
                selection == 4 ? Image(systemName: "mappin.circle.fill") : Image(systemName: "mappin.circle")
           
                Text("Local")
            }
            .tag(4)
            
        }
        .accentColor(Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)))
//        .onAppear() {
//            UITabBar.appearance().barTintColor = .white
//        }
     
            HStack {
                Button(action: {
                selection = (selection - 1) % 5
            }) {
                Text("Back")
                    .font(.system(.headline, design: .rounded))
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)))
                    .cornerRadius(10.0)
                    .shadow(color: Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)).opacity(0.2), radius: 10, x: 0, y: 12)
                    .shadow(color: Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)).opacity(0.1), radius: 1, x: 0, y: 1)
                    .padding()
         
                }
            
        
        Spacer()
        
        Button(action: {
            selection = (selection + 1) % 5
        }) {
            Text("Next")
                .font(.system(.headline, design: .rounded))
                .padding()
                .foregroundColor(.white)
                .background(Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)))
                .cornerRadius(10.0)
                .shadow(color: Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)).opacity(0.2), radius: 10, x: 0, y: 12)
                .shadow(color: Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)).opacity(0.1), radius: 1, x: 0, y: 1)
                .padding()
     
        }
            }
            .offset(y: 100)
            
        }
       
    }
}


struct MapTabView_Previews: PreviewProvider {
    static var previews: some View {
        MapTabView()
    }
}
