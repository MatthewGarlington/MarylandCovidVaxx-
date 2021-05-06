//
//  TotalVaccineData.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 5/5/21.
//

import SwiftUI

class TotalVaccineDataViewModel: ObservableObject {

    @Published var sectionsRowTwo: [SectionSecondRow] = []
    @Published var sections: [Section] = []
    @Published var sectionsRowThree: [SectionThirdRow] = []
    @Published var sectionFourthRow: [SectionFourthRow] = []
    @Published var ringView: [RingView] = []
    @Published var recentMDVaccineTotals: MDTotalVaccine?
    @Published var vaccinePercentChange: [VaccinePercentDifferenceRow] = []

    let titles = ["Number 1st Dose Given", "24 Hour Change of 1st Doses Given:", "Percent of Population 1st Dose Received", "Number 2nd Dose Received", "24 Hour Change of 2nd Doses Given", "Percent of Population 2nd Dose Received", "All Doses Administered", "Doses Received", "All Dose Distributed", "Number of 2nd Dose Given", "2nd Doses Distributed" , "Fully Vaccinated", ""]
    var index2 = 0

    init() {


        let url = URL(string: "https://services.arcgis.com/njFNhDsUCentVYJW/arcgis/rest/services/MD_COVID19_VaccinationMetrics/FeatureServer/0/query?where=1%3D1&outFields=Metric,Value&outSR=4326&f=json")!



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
            //            guard let allVaccineJSON = try? JSONDecoder().decode(MDTotalVaccine?.self, from: data) else {
            //               print("Error: Couldn't decode data into all data in MD Info")
            //               return
            //             }
            ////
            //            print("gotten json response dictionary is \n \(allVaccineJSON)")
            // update UI using the response here

            DispatchQueue.main.async {

                do {
                    
                    self.recentMDVaccineTotals = try JSONDecoder().decode(MDTotalVaccine?.self, from: data)



                    // Percent Change for Vaccine Total Postive Change

                    self.vaccinePercentChange.append(VaccinePercentDifferenceRow(text: "+\(self.recentMDVaccineTotals?.features?[4].attributes?.Value ?? 0)"))

                    // First Row

                    self.sections.append(Section(title:  self.titles[6],
                                                 text: Text("\(self.recentMDVaccineTotals?.features?[13].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                 image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                 color: .blue))
                    self.sections.append(Section(title:  self.titles[8],
                                                 text: Text("\(self.recentMDVaccineTotals?.features?[6].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                 image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                 color: .blue))
                    self.sections.append(Section(title:  self.titles[11],
                                                 text: Text("\(self.recentMDVaccineTotals?.features?[15].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                 image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                 color: .blue))



                    // Second Row
                    self.sectionsRowTwo.append(SectionSecondRow(title:  self.titles[0],
                                                                text: Text("\(self.recentMDVaccineTotals?.features?[7].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                                image: URL(string: "https://khn.org/wp-content/uploads/sites/2/2020/12/GettyImages-1263990592_1350.jpg?w=1270")!,
                                                                logo: #imageLiteral(resourceName: "Logo1"),
                                                                color: .blue))

                    self.sectionsRowTwo.append(SectionSecondRow(title:  self.titles[1],
                                                                text: Text("+\(self.recentMDVaccineTotals?.features?[0].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                                image: URL(string: "https://khn.org/wp-content/uploads/sites/2/2020/12/GettyImages-1263990592_1350.jpg?w=1270")!,
                                                                logo: #imageLiteral(resourceName: "Logo1"),
                                                                color: .blue))
                    self.sectionsRowTwo.append(SectionSecondRow(title:  self.titles[2],
                                                                text: Text("\(self.recentMDVaccineTotals?.features?[8].attributes?.Value ?? 0, specifier: "%.2f")%"),
                                                                image: URL(string: "https://khn.org/wp-content/uploads/sites/2/2020/12/GettyImages-1263990592_1350.jpg?w=1270")!,
                                                                logo: #imageLiteral(resourceName: "Logo1"),
                                                                color: .blue))


                    // Third Row
                    self.sectionsRowThree.append(SectionThirdRow(title:  self.titles[9],
                                                                 text: Text("\(self.recentMDVaccineTotals?.features?[9].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                                 image: URL(string: "https://labblog.uofmhealth.org/sites/lab/files/2020-08/CovidVaccineBlog_0.jpg")!,
                                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                                 color: .blue))
                    self.sectionsRowThree.append(SectionThirdRow(title:  self.titles[4],
                                                                 text: Text("+\(self.recentMDVaccineTotals?.features?[2].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                                 image: URL(string: "https://labblog.uofmhealth.org/sites/lab/files/2020-08/CovidVaccineBlog_0.jpg")!,
                                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                                 color: .blue))
                    self.sectionsRowThree.append(SectionThirdRow(title:  self.titles[5],
                                                                 text: Text("\(self.recentMDVaccineTotals?.features?[10].attributes?.Value ?? 0, specifier: "%.2f")%"),
                                                                 image: URL(string: "https://labblog.uofmhealth.org/sites/lab/files/2020-08/CovidVaccineBlog_0.jpg")!,
                                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                                 color: .blue))
                    // Fourth Row

                    self.sectionFourthRow.append(SectionFourthRow(
                                                                  title: "Single Shot Doses Given",
                                                                  text: Text("\(self.recentMDVaccineTotals?.features?[11].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                    image: URL(string:"https://dhis2.org/wp-content/uploads/package-CovidVaccine.png")!,
                                                                  logo: #imageLiteral(resourceName: "Logo1"),
                                                                  color: .systemPink))
                    self.sectionFourthRow.append(SectionFourthRow(
                                                                  title: "24 Hour Change of Single doses given",
                                                                  text: Text("\(self.recentMDVaccineTotals?.features?[2].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                    image: URL(string:"https://dhis2.org/wp-content/uploads/package-CovidVaccine.png")!,
                                                                  logo: #imageLiteral(resourceName: "Logo1"),
                                                                  color: .systemPink))
                    self.sectionFourthRow.append(SectionFourthRow(
                                                                  title: "Percent of Population of Single doses",
                                                                  text: Text("\(self.recentMDVaccineTotals?.features?[12].attributes?.Value ?? 0, specifier: "%.2f")%"),
                                                    image: URL(string:"https://dhis2.org/wp-content/uploads/package-CovidVaccine.png")!,
                                                                  logo: #imageLiteral(resourceName: "Logo1"),
                                                                  color: .systemPink))





                } catch let jsonError {

                    print("Decoding failed for Vaccine Data", jsonError)
                }
            }


        }


        // execute the HTTP request
        task.resume()

    }
}
