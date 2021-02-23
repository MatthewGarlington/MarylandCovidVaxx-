//
//  HospitalList.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/23/21.
//

import SwiftUI

struct HospitalList: View {
    @ObservedObject var casesModel = CovidMasterModel()

    var body: some View {
 
        NavigationView {
        List {
            ForEach(casesModel.allMDHeader.reversed(), id: \.self) { cases in
       
                    
                    HStack {

                        
            
                        VStack(alignment: .leading, spacing: 12) {
                           
                            
                            VStack(alignment: .leading, spacing: 10) {




                                Text("\((cases.reportdate?.getDateFormatterForString(dateString: cases.reportdate ?? ""))!):")
                                    .font(.system(size: 20, weight: .bold))


                          

                                VStack(alignment: .leading) {
                                    HStack(spacing: 10) {
                                        HStack {
                                            
                                            Text("Total Hospitalized:")
                                                .bold()
                                            
                                            Text("\(cases.total_hospitalized ?? "")")
                                                .font(.system(size: 20, weight: .semibold))
                                        }



                                    VStack(alignment: .leading) {
                                        Text("+\(cases.hospitalizeddelta ?? "")")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundColor(.secondary)
                                        Spacer()
                                    }
                                    }
                                    
                                    HStack(spacing: 10) {
                                        HStack {
                                            
                                            Text("Total in ICU:")
                                                .bold()
                                            
                                            Text("\(cases.bedsicu ?? "")")
                                                .font(.system(size: 20, weight: .semibold))
                                        }



                                    }
                                    
                                    HStack(spacing: 10) {
                                        HStack {
                                            
                                            Text("Total in Acute Care:")
                                                .bold()
                                            
                                            Text("\(cases.bedsacute ?? "")")
                                                .font(.system(size: 20, weight: .semibold))
                                        }



                                    }
                                }
                            }
                          
                            
                            
                        
 
                            
                        }
                    }
                    .padding(.vertical, 8)
                
            }
            .navigationBarTitle("History of Total Case numbers")
            .navigationBarTitleDisplayMode(.inline)
        }
       
    
      
        }
    
}
}


struct HospitalList_Previews: PreviewProvider {
    static var previews: some View {
        HospitalList()
    }
}



