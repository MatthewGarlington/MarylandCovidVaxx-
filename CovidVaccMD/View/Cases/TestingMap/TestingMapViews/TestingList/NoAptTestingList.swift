//
//  NoAptList.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/25/21.
//

import SwiftUI

struct NoAptTestingList: View {
    @ObservedObject var viewModel = NoAppointmentRequiredTestingLocationsViewModel()
    var body: some View {
        NavigationView {
        List {
       
            ForEach(viewModel.testingTestingLocations?.features ?? [], id: \.self) { testing in
                NavigationLink(destination: TestingLocationsDetail(testing: testing)) {
                    
                    HStack {
                        
//                        Image(vaccine)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 80, height: 80)
//                            .background(Color.black)
//                            .cornerRadius(20)
//                            .padding(.trailing, 4)
                        
            
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
            
            
//             .padding(.top, 8)
//             .padding(.horizontal, 20)
//            // Lets the bottom card with the Text Field to not take up the entire width of the screen
//         //   .frame(maxWidth: 712)
//            .frame(height: 175)
//            // Adding the BlurView Modifer to give a glass appearance
//            .background(BlurView(style: .systemThinMaterial))
//            .cornerRadius(30)
//            .frame(maxWidth: .infinity)
//           // .frame(maxWidth: .infinity)
//            .listRowBackground(BlurView(style: .systemThinMaterial))
        }
        .navigationBarHidden(false)
    }
      
     
    
}
}

struct NoAptTestingList_Previews: PreviewProvider {
    static var previews: some View {
        NoAptTestingList()
    }
}
