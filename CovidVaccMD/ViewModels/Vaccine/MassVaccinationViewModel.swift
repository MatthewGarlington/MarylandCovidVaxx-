//
//  MassVaccinationViewModel.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 5/5/21.
//

import SwiftUI

class MassVaccinationViewModel: ObservableObject {


    @Published var vaccineLocationsMD: MDVaccineLocations?




    init() {



        let url = URL(string: "https://services.arcgis.com/njFNhDsUCentVYJW/arcgis/rest/services/MD_Vaccination_Locations/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json")!


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
            //            guard let locationVaccine = try? JSONDecoder().decode(MDVaccineLocations.self, from: data) else {
            //               print("Error: Couldn't decode data into all data in MD Info")
            //               return
            //             }
            ////
            //            print("gotten json response dictionary is \n \(locationVaccine)")
            // update UI using the response here

            DispatchQueue.main.async {

                do {

                    self.vaccineLocationsMD = try JSONDecoder().decode(MDVaccineLocations?.self, from: data)


               //     print(self.vaccineLocationsMD)





                } catch let jsonError {

                    print("Decoding failed for UserDetails", jsonError)
                }
            }


        }


        // execute the HTTP request
        task.resume()

    }
}
