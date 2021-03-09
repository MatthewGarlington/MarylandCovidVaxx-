//
//  AllTestingList.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/25/21.
//

import SwiftUI
import Combine

struct AllTestingList: View {
    
    @ObservedObject var allTestingLocations = AllTestingLocations()
    @ObservedObject var viewModel = ContentViewModel()
    var body: some View {
        NavigationView {
            
            VStack {

                List {
       
            ForEach(allTestingLocations.testingTestingLocations?.features ?? [], id: \.self) { testing in
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

class ContentViewModel: ObservableObject {
    // 2
    @Published var searchText = ""
   
    // 3
    let allData: [String]
    var filteredData: [String] = [String]()
    var publisher: AnyCancellable?
    init() {
        // 4
        self.allData = (0..<200).map({ "\($0)" })
        self.filteredData = allData
        self.publisher = $searchText
            .receive(on: RunLoop.main)
            .sink(receiveValue: { (str) in
                if !self.searchText.isEmpty {
                    self.filteredData = self.allData.filter { $0.contains(str) }
                } else {
                    self.filteredData = self.allData
                }
            })

        
    }
}
