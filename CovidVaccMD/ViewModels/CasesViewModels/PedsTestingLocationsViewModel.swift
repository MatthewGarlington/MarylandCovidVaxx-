//
//  PedsTestingLocations.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 5/5/21.
//

import SwiftUI

class PedsTestingLocationsViewModel: ObservableObject {


    @Published var testingTestingLocations: MDTestingLocations?




    init() {



        let url = URL(string: "https://services.arcgis.com/njFNhDsUCentVYJW/arcgis/rest/services/MD_COVID19_Testing_Sites/FeatureServer/4/query?where=1%3D1&outFields=*&outSR=4326&f=json")!


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



            DispatchQueue.main.async {

                do {

                    self.testingTestingLocations = try JSONDecoder().decode(MDTestingLocations?.self, from: data)



                } catch let jsonError {

                    print("Decoding failed for UserDetails", jsonError)
                }
            }


        }


        // execute the HTTP request
        task.resume()

    }
}
