//
//  DeathList.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/23/21.
//

import SwiftUI

struct DeathList: View {
    @ObservedObject var casesModel = CovidMasterModel()

    var body: some View {
        NavigationView {
        List {
            ForEach(casesModel.allDeaths.reversed(), id: \.self) { deaths in
       
                    
                    HStack {

                        
            
                        VStack(alignment: .leading, spacing: 12) {
                           
                            
                            VStack(alignment: .leading, spacing: 10) {




                                Text("\((deaths.reportdate?.getDateFormatterForString(dateString: deaths.reportdate ?? ""))!):")
                                    .font(.system(size: 20, weight: .bold))


                          

                                VStack(alignment: .leading) {
                                    HStack(spacing: 10) {
                                        HStack {
                                            
                                            Text("Total Deaths:")
                                                .bold()
                                            
                                            Text("\(deaths.deaths ?? "")")
                                                .font(.system(size: 20, weight: .semibold))
                                        }



                                    VStack(alignment: .leading) {
                                        Text("+\(deaths.deathsdelta ?? "")")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundColor(.secondary)
                                        Spacer()
                                    }
                                    }
                                    
//                                    HStack(spacing: 10) {
//                                        HStack {
//
//                                            Text("Total in ICU:")
//                                                .bold()
//
//                                            Text("\(cases.bedsicu ?? "")")
//                                                .font(.system(size: 20, weight: .semibold))
//                                        }
//
//
//
//                                    }
//
//                                    HStack(spacing: 10) {
//                                        HStack {
//
//                                            Text("Total in Acute Care:")
//                                                .bold()
//
//                                            Text("\(cases.bedsacute ?? "")")
//                                                .font(.system(size: 20, weight: .semibold))
//                                        }
//
//
//
//                                    }
                                }
                            }
                          
                            
                            
                        
 
                            
                        }
                    }
                    .padding(.vertical, 8)
                
            }
            .navigationBarTitle("History of Total Deaths")
            .navigationBarTitleDisplayMode(.inline)
        }
       
    
      
        }
    


    
}
}
struct DeathList_Previews: PreviewProvider {
    static var previews: some View {
        DeathList()
    }
}
