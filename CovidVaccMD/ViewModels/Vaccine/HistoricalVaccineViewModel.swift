//
//  HistoricalVaccineData.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 5/5/21.
//

import SwiftUI

class HistoricalVaccineViewModel: ObservableObject {


    @Published var recentMDVaccineTotals: MDHistoricalVaccine?

    init() {

        let url = URL(string: "https://services.arcgis.com/njFNhDsUCentVYJW/arcgis/rest/services/MD_COVID19_TotalVaccinationsStatewideFirstandSecondSingleDose/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json")!

        let task =  URLSession.shared.dataTask(with: url) { data, response, error in

            // ensure there is no error for this HTTP response
            guard error == nil else {
                print ("error: \(error!)")
                return
            }

            // ensure there is data returned from this HTTP response
            guard let data = data else {
                print("No data")
                return
            }

            // Parse JSON into newJSON struct using JSONDecoder
//                        guard let allVaccineJSON = try? JSONDecoder().decode(MDHistoricalVaccine?.self, from: data) else {
//                           print("Error: Couldn't decode data into all data in MD Info")
//                           return
//                         }
//            //
//                        print("gotten json response dictionary is \n \(allVaccineJSON)")
            // update UI using the response here
//
            DispatchQueue.main.async {

                do {



                    self.recentMDVaccineTotals = try JSONDecoder().decode(MDHistoricalVaccine?.self, from: data)



                    for i in stride(from: 1, through: (((self.recentMDVaccineTotals?.features?.count ?? 0)-1)), by: 1) {

//                        print(
//                            (((self.recentMDVaccineTotals?.features?[i].attributes?.CumulativeTotalVaccinated ?? 2)) -
//                                (self.recentMDVaccineTotals?.features?[i - 1].attributes?.CumulativeTotalVaccinated ?? 1)))

                    }

                } catch let jsonError {

                    print("Decoding failed for Vaccine Data", jsonError)
                }
            }
        }
        // execute the HTTP request
        task.resume()

    }
}
