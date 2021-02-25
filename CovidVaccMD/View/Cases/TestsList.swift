//
//  TestsList.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/25/21.
//

import SwiftUI

struct TestsList: View {
    @ObservedObject var casesModel = CovidMasterModel()

    var body: some View {
 
        NavigationView {
        List {
            ForEach(casesModel.allMDHeader.reversed(), id: \.self) { cases in
       
                    
                    HStack {

                        
            
                        VStack(alignment: .leading, spacing: 12) {
                           
                            
                            HStack(spacing: 10) {
                                 
                           
                               
                                
                                Text("\((cases.reportdate?.getDateFormatterForString(dateString: cases.reportdate ?? ""))!):")
                                    .font(.system(size: 20, weight: .bold))
                                
                                
                                Spacer()
                                
                                HStack(spacing: 10) {
                                    Text("\(cases.totaltests ?? "")")
                                        .font(.system(size: 20, weight: .semibold))
                                    
                                
                                
                                VStack(alignment: .leading) {
                                    Text("+\(cases.testsdelta ?? "")")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.secondary)
                                    Spacer()
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


struct TestsList_Previews: PreviewProvider {
    static var previews: some View {
        TestsList()
    }
}