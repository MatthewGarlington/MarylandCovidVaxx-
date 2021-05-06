//
//  CovidMasterModel.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 5/5/21.
//

import SwiftUI

class CovidMasterVM: ObservableObject {


    @Published var allMDHeader = [MDHeader]()
    @Published var allDeaths = [MDDataDeath]()
    @Published var allMDCases = [MDCases]()
    @Published var casesRowOne: [CasesRowOne] = []
    @Published var hospitalRowTwo: [HospitalRow] = []
    @Published var confirmedDeaths: [DeathRow] = []
    @Published var percentChange: [PercentDifferenceRow] = []
    @Published var testsRow: [TestRow] = []






    init() {



        let url = URL(string: "https://opendata.maryland.gov/resource/mgd3-qk8t.json")!


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
//                        guard let locationVaccine = try? JSONDecoder().decode([MDHeader].self, from: data) else {
//                           print("Error: Couldn't decode data into all data in MD Info")
//                           return
//                         }
//            //
//                        print("gotten json response dictionary is \n \(locationVaccine)")
            // update UI using the response here

            DispatchQueue.main.async {

                do {

                    self.allMDHeader = try JSONDecoder().decode([MDHeader].self, from: data)
                    self.allMDCases = try JSONDecoder().decode([MDCases].self, from: data)
                    self.allDeaths = try JSONDecoder().decode([MDDataDeath].self, from: data)

                 //   print(self.allMDHeader[self.allMDHeader.count - 1].totalcases ?? "nothing to show")

                 //   print(Int(self.allMDHeader[self.allMDHeader.count - 1].totalcases ?? "Nothing to show") ?? 0)




                    // Format Date given that is a string



                    let string = "\(self.allMDHeader[0].reportdate!)"

                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
                    let newString = dateFormatter.date(from:string)
                    dateFormatter.dateStyle = .medium
                    print(dateFormatter.string(from: newString!))

                   // Percent Change for Testing Postiive
                    self.percentChange.append(PercentDifferenceRow(text: "\(self.allMDHeader[self.allMDHeader.count - 1].pospercentdiff ?? "No Data")"))




                    // Tests row

                    self.testsRow.append(TestRow(title: "Total Tests",
                                                 text: (Int(self.allMDHeader[self.allMDHeader.count - 1].totaltests ?? "Nothing to show") ?? 0),
                                                 image: URL(string: "https://techcrunch.com/wp-content/uploads/2020/03/GettyImages-1210572469.jpg")!,
                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                 color: .blue))
                    self.testsRow.append(TestRow(title: "24 Hour Change in Tests",
                                                 text: (Int(self.allMDHeader[self.allMDHeader.count - 1].testsdelta ?? "") ?? 0),
                                                 image: URL(string: "https://techcrunch.com/wp-content/uploads/2020/03/GettyImages-1210572469.jpg")!,
                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                 color: .blue))




                    // Cases Row

                    self.casesRowOne.append(CasesRowOne(title: "Total Cases",
                                                        text: (Int(self.allMDHeader[self.allMDHeader.count - 1].totalcases ?? "") ?? 0),
                                                        image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                        logo: #imageLiteral(resourceName: "Logo1"),
                                                        color: .blue))

                    self.casesRowOne.append(CasesRowOne(title: "24 Hour Change in Cases",
                                                        text: (Int(self.allMDHeader[self.allMDHeader.count - 1].casedelta ?? "") ?? 0),
                                                        image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                        logo: #imageLiteral(resourceName: "Logo1"),
                                                        color: .blue))


                    // Hospital Row

                    self.hospitalRowTwo.append(HospitalRow(title: "Total Hospitalized",
                                                        text: (Int(self.allMDHeader[self.allMDHeader.count - 1].total_hospitalized ?? "") ?? 0),
                                                        image: URL(string: "https://khn.org/wp-content/uploads/sites/2/2020/12/GettyImages-1263990592_1350.jpg?w=1270")!,
                                                        logo: #imageLiteral(resourceName: "Logo1"),
                                                        color: .blue))

                    self.hospitalRowTwo.append(HospitalRow(title: "24 Hour Change in Hospitalizations",
                                                        text: (Int(self.allMDHeader[self.allMDHeader.count - 1].hospitalizeddelta ?? "") ?? 0),
                                                        image:  URL(string: "https://khn.org/wp-content/uploads/sites/2/2020/12/GettyImages-1263990592_1350.jpg?w=1270")!,
                                                        logo: #imageLiteral(resourceName: "Logo1"),
                                                        color: .blue))


                    //Death Row

                    self.confirmedDeaths.append(DeathRow(title: "Total Confirmed Deaths",
                                                         text: (Int(self.allDeaths[self.allDeaths.count - 1].deaths ?? "") ?? 0),
                                                         image: URL(string: "https://labblog.uofmhealth.org/sites/lab/files/2020-08/CovidVaccineBlog_0.jpg")!,
                                                         logo: #imageLiteral(resourceName: "Logo1"),
                                                         color: .blue))

                    self.confirmedDeaths.append(DeathRow(title: "24 Hour Change in Confirmed Deaths",
                                                         text: (Int(self.allDeaths[self.allDeaths.count - 1].deathsdelta ?? "") ?? 0),
                                                         image: URL(string: "https://labblog.uofmhealth.org/sites/lab/files/2020-08/CovidVaccineBlog_0.jpg")!,
                                                         logo: #imageLiteral(resourceName: "Logo1"),
                                                         color: .blue))






                } catch let jsonError {

                    print("Decoding failed for All Maryland Covid Data", jsonError)
                }
            }


        }


        // execute the HTTP request
        task.resume()

    }
}
