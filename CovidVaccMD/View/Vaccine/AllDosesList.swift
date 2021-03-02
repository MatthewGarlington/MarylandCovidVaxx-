//
//  AllDosesList.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 3/1/21.
//

import SwiftUI

struct AllDosesList: View {
    @ObservedObject var vaccineHistoricalViewModel = HistoricalVaccineData()
    


    var body: some View {
 
        NavigationView {
        List {
            ForEach(vaccineHistoricalViewModel.recentMDVaccineTotals?.features?.reversed() ?? [], id: \.self) { vaccine in
       
                    
                    HStack {

                        
            
                        VStack(alignment: .leading, spacing: 12) {
                           
                            
                            HStack(spacing: 40) {
                                 
                                
                               
                                
                                Text("\((vaccine.attributes?.CumulativeTotalVaccinatedDate?.getDateFromCrazyInt(date: vaccine.attributes!.CumulativeTotalVaccinatedDate!))!):")
                                        .font(.system(size: 20, weight: .bold))
                       
                     
                                VStack(alignment: .leading) {
                                    Text("\(vaccine.attributes?.CumulativeTotalVaccinated ?? 0)")
                                            .font(.system(size: 20, weight: .semibold))
                                    
                                 
                                }

                            }
                        }
                    }
                    .padding(.vertical, 8)
                
            }
          
        }
       
        .navigationBarTitle("History of Total Vaccinations")
        .navigationBarTitleDisplayMode(.inline)
      
        }
    
}
}

struct AllDosesList_Previews: PreviewProvider {
    static var previews: some View {
        AllDosesList()
    }
}
