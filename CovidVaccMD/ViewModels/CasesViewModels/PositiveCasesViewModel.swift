//
//  PositiveCasesViewModel.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 5/5/21.
//

import SwiftUI


class PositiveCasesViewModel: ObservableObject {
    @Published var positiveCases: MDPositiveCases?

    init() {

        let url = URL(string: "https://services.arcgis.com/njFNhDsUCentVYJW/arcgis/rest/services/MDCOVID19_TestingVolume/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json")!


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
//                        guard let positiveCases = try? JSONDecoder().decode(MDPositiveCases?.self, from: data) else {
//                           print("Error: Couldn't decode data into all data in MD Info")
//                           return
//                         }
//            //
//                        print("gotten json response dictionary is \n \(positiveCases)")
            // update UI using the response here
//
            DispatchQueue.main.async {

                do {
                    self.positiveCases = try JSONDecoder().decode(MDPositiveCases?.self, from: data)

                    let epochTime2 = TimeInterval((self.positiveCases?.features?[(self.positiveCases?.features!.count)! - 1].attributes?.date ?? 0)) / 1000
                    let date2 = Date(timeIntervalSince1970: epochTime2)
                    let formate = date2.getFormattedDate(format: "MM-dd-yyyy")
                   // print(formate)

                } catch let jsonError {

                    print("Decoding failed for UserDetails", jsonError)
                }
            }
        }
        // execute the HTTP request
        task.resume()

    }
}
