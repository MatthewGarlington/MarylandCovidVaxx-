//
//  AllTestingList.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/25/21.
//

import SwiftUI
import Combine

struct AllTestingList: View {
    
    @ObservedObject var viewModel = AllTestingLocationsViewModel()
    var body: some View {
        NavigationView {
            
            VStack {

                List {
       
            ForEach(viewModel.testingTestingLocations?.features ?? [], id: \.self) { testing in
                NavigationLink(destination: TestingLocationsDetail(testing: testing)) {
                    
                    HStack {
                        

            
                        VStack(alignment: .leading, spacing: 12) {
           
                            Text("\(testing.attributes?.name ?? "")")
                                .font(.system(size: 20, weight: .bold))
                                
                            Text("\(testing.attributes?.fulladdr ?? "")")
                                .lineLimit(2)
                                .font(.subheadline)
                            
            
                            
                            Text("\(testing.attributes?.operationalhours ?? "")")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                            
                  

                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            

        }
        .navigationBarHidden(false)
    }
            
        }
      
     
    
}
}

struct AllTestingList_Previews: PreviewProvider {
    static var previews: some View {
        AllTestingList()
    }
}


