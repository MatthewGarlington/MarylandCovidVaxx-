//
//  MDCurrentlyHospitalizedViewModel.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 5/5/21.
//

import SwiftUI

class MDCurrentlyHospitalizedViewModel: ObservableObject {


    @Published var currentHospitalizedData: MDTotalCurrentHospital?
    @Published var hospitalRowTwo: [HospitalRow] = []





    init() {



        let url = URL(string: "https://services.arcgis.com/njFNhDsUCentVYJW/arcgis/rest/services/MDCOVID19_TotalCurrentlyHospitalizedAcuteAndICU/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json")!


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



                    self.currentHospitalizedData = try JSONDecoder().decode(MDTotalCurrentHospital?.self, from: data)


                    self.hospitalRowTwo.append(HospitalRow(title: "Current Hospitalized",
                                                             text: (Int(self.currentHospitalizedData?.features?[(self.currentHospitalizedData?.features!.count)! - 1].attributes?.Total ?? 0) ?? 0),
                                                         image: URL(string: "https://khn.org/wp-content/uploads/sites/2/2020/12/GettyImages-1263990592_1350.jpg?w=1270")!,
                                                         logo: #imageLiteral(resourceName: "Logo1"),
                                                         color: .blue))
                    self.hospitalRowTwo.append(HospitalRow(title: "Currently in ICU",
                                                           text: (Int(self.currentHospitalizedData?.features?[(self.currentHospitalizedData?.features!.count)! - 1].attributes?.ICU ?? 0) ?? 0),
                                                         image: URL(string: "https://khn.org/wp-content/uploads/sites/2/2020/12/GettyImages-1263990592_1350.jpg?w=1270")!,
                                                         logo: #imageLiteral(resourceName: "Logo1"),
                                                         color: .blue))

                    self.hospitalRowTwo.append(HospitalRow(title: "Currently in Acute Care",
                                                           text: (Int(self.currentHospitalizedData?.features?[(self.currentHospitalizedData?.features!.count)! - 1].attributes?.Acute ?? 0) ?? 0),
                                                         image: URL(string: "https://khn.org/wp-content/uploads/sites/2/2020/12/GettyImages-1263990592_1350.jpg?w=1270")!,
                                                         logo: #imageLiteral(resourceName: "Logo1"),
                                                         color: .blue))





                } catch let jsonError {

                    print("Decoding failed for UserDetails", jsonError)
                }
            }


        }


        // execute the HTTP request
        task.resume()

    }
}
