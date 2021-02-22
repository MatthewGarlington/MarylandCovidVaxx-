//
//  VaccineLocationsListView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/20/21.
//

import SwiftUI

struct VaccineLocationsListView: View {
    @ObservedObject var vaccineLocations = VaccineLocationsModel()
    var body: some View {
        NavigationView {
        List {
            ForEach(vaccineLocations.vaccineLocationsMD?.features ?? [], id: \.self) { vaccine in
                NavigationLink(destination: VaccineLocationsDetails(vaccine: vaccine)) {
                    
                    HStack {
                        
//                        Image(vaccine)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 80, height: 80)
//                            .background(Color.black)
//                            .cornerRadius(20)
//                            .padding(.trailing, 4)
                        
            
                        VStack(alignment: .leading, spacing: 12) {
           
                            Text("\(vaccine.attributes?.name ?? "")")
                                .font(.system(size: 20, weight: .bold))
                                
                            Text("\(vaccine.attributes?.fulladdr ?? "")")
                                .lineLimit(2)
                                .font(.subheadline)
                            
            
                            
                            Text("\(vaccine.attributes?.operationalhours ?? "")")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                            
                  
                        
                            
                            
                            
                      
                                
                            
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            
             .padding(.top, 8)
             .padding(.horizontal, 20)
            // Lets the bottom card with the Text Field to not take up the entire width of the screen
         //   .frame(maxWidth: 712)
            .frame(height: 175)
            // Adding the BlurView Modifer to give a glass appearance
            .background(BlurView(style: .systemThinMaterial))
            .cornerRadius(30)
            .frame(maxWidth: .infinity)
           // .frame(maxWidth: .infinity)
            .listRowBackground(BlurView(style: .systemThinMaterial))
        }
        .navigationBarHidden(true)
    }
      
     
    
}
}

let vaccineData = VaccineLocationsFeatures(attributes: VaccineLocationAttributes.init(name: "", fulladdr: "", municipality: "", ActiveYesNo: "", operationalhours: "", cost_notes: "", schedule_url: "", online_scheduling: "", scheduling_contact: "", scheduling_contact_phone: "", scheduling_contact_email: "", test_pcr: "", website_url: "", created_date: 1, last_edited_date: 10-10-1000), geometry: Geometry(x: 100, y: 100))
    





struct VaccineLocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        VaccineLocationsListView()
    }
}
