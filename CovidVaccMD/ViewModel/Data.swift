//
//  Data.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//

import SwiftUI
import MapKit



class Api {
    // The completion allows to return an array of the items in Post
    func getPosts(completion: @escaping ([Post]) -> ()) {
        
        // The URL used gives us fake json data useful for prototyping
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            
            // Prevent Crashing by taking away the ! in data below with adding guard let
            guard let data = data else { return }
            
            let posts = try! JSONDecoder().decode([Post].self, from: data)
            
            
            // Using the Dispatch call allows to run they API while continue to use the app
            
            DispatchQueue.main.async {
                
                // complete the Post Array
                completion(posts)
            }
            
            
            
        }
        .resume()
    }
}



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
                                                             text: "\(self.currentHospitalizedData?.features?[(self.currentHospitalizedData?.features!.count)! - 1].attributes?.Total ?? 0)",
                                                         image: URL(string: "https://khn.org/wp-content/uploads/sites/2/2020/12/GettyImages-1263990592_1350.jpg?w=1270")!,
                                                         logo: #imageLiteral(resourceName: "Logo1"),
                                                         color: .blue))
                    self.hospitalRowTwo.append(HospitalRow(title: "Currently in ICU",
                                                           text: "\(self.currentHospitalizedData?.features?[(self.currentHospitalizedData?.features!.count)! - 1].attributes?.ICU ?? 0)",
                                                         image: URL(string: "https://khn.org/wp-content/uploads/sites/2/2020/12/GettyImages-1263990592_1350.jpg?w=1270")!,
                                                         logo: #imageLiteral(resourceName: "Logo1"),
                                                         color: .blue))
                    
                    self.hospitalRowTwo.append(HospitalRow(title: "Currently in Acute Care",
                                                           text: "\(self.currentHospitalizedData?.features?[(self.currentHospitalizedData?.features!.count)! - 1].attributes?.Acute ?? 0)",
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

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}


class CovidMasterModel: ObservableObject {
    
    
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
                    
                    print(self.allMDHeader[300].totalcases ?? "nothing to show")
                    
                    
          
                    
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
                                                 text: "\(self.allMDHeader[self.allMDHeader.count - 1].totaltests ?? "")",
                                                 image: URL(string: "https://techcrunch.com/wp-content/uploads/2020/03/GettyImages-1210572469.jpg")!,
                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                 color: .blue))
                    self.testsRow.append(TestRow(title: "24 Hour Change in Tests",
                                                 text: "+\(self.allMDHeader[self.allMDHeader.count - 1].casedelta ?? "")",
                                                 image: URL(string: "https://techcrunch.com/wp-content/uploads/2020/03/GettyImages-1210572469.jpg")!,
                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                 color: .blue))
                    
                
     
                
                    // Cases Row
                    
                    self.casesRowOne.append(CasesRowOne(title: "Total Cases",
                                                        text: "\(self.allMDHeader[self.allMDHeader.count - 1].totalcases ?? "")",
                                                        image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                        logo: #imageLiteral(resourceName: "Logo1"),
                                                        color: .blue))
                    
                    self.casesRowOne.append(CasesRowOne(title: "24 Hour Change in Cases",
                                                        text: "+\(self.allMDHeader[self.allMDHeader.count - 1].casedelta ?? "")",
                                                        image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                        logo: #imageLiteral(resourceName: "Logo1"),
                                                        color: .blue))
                    
                    
                    // Hospital Row
                
                    self.hospitalRowTwo.append(HospitalRow(title: "Total Hospitalized",
                                                        text: "\(self.allMDHeader[self.allMDHeader.count - 1].total_hospitalized ?? "")",
                                                        image: URL(string: "https://khn.org/wp-content/uploads/sites/2/2020/12/GettyImages-1263990592_1350.jpg?w=1270")!,
                                                        logo: #imageLiteral(resourceName: "Logo1"),
                                                        color: .blue))
                    
                    self.hospitalRowTwo.append(HospitalRow(title: "24 Hour Change in Hospitalizations",
                                                        text: "+\(self.allMDHeader[self.allMDHeader.count - 1].hospitalizeddelta ?? "")",
                                                        image:  URL(string: "https://khn.org/wp-content/uploads/sites/2/2020/12/GettyImages-1263990592_1350.jpg?w=1270")!,
                                                        logo: #imageLiteral(resourceName: "Logo1"),
                                                        color: .blue))
                 
                  
                    //Death Row
                    
                    self.confirmedDeaths.append(DeathRow(title: "Total Confirmed Deaths",
                                                         text: "\(self.allDeaths[self.allDeaths.count - 1].deaths ?? "")",
                                                         image: URL(string: "https://labblog.uofmhealth.org/sites/lab/files/2020-08/CovidVaccineBlog_0.jpg")!,
                                                         logo: #imageLiteral(resourceName: "Logo1"),
                                                         color: .blue))
                    
                    self.confirmedDeaths.append(DeathRow(title: "24 Hour Change in Confirmed Deaths",
                                                         text: "+\(self.allDeaths[self.allDeaths.count - 1].deathsdelta ?? "")",
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





class LocalHealthVaccineLocationsModel: ObservableObject {
    
    
    @Published var vaccineLocationsMD: MDVaccineLocations?
    
    
    
    
    init() {
        
        
        
        let url = URL(string: "https://services.arcgis.com/njFNhDsUCentVYJW/arcgis/rest/services/MD_Vaccination_Locations/FeatureServer/2/query?where=1%3D1&outFields=*&outSR=4326&f=json")!
        
        
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
                    
      
                    
                    
                    
                    
                    
                    
                } catch let jsonError {
                    
                    print("Decoding failed for UserDetails", jsonError)
                }
            }
            
            
        }
        
        
        // execute the HTTP request
        task.resume()
        
    }
}

class HospitalVaccineLocationsModel: ObservableObject {
    
    
    @Published var vaccineLocationsMD: MDVaccineLocations?
    
    
    
    
    init() {
        
        
        
        let url = URL(string: "https://services.arcgis.com/njFNhDsUCentVYJW/arcgis/rest/services/MD_Vaccination_Locations/FeatureServer/3/query?where=1%3D1&outFields=*&outSR=4326&f=json")!
        
        
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
                    
      
                    
                    
                    
                    
                    
                    
                } catch let jsonError {
                    
                    print("Decoding failed for UserDetails", jsonError)
                }
            }
            
            
        }
        
        
        // execute the HTTP request
        task.resume()
        
    }
}


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

class RetailVaccinationViewModel: ObservableObject {
    
    
    @Published var vaccineLocationsMD: MDVaccineLocations?
    
    
    
    
    init() {
        
        
        
        let url = URL(string: "https://services.arcgis.com/njFNhDsUCentVYJW/arcgis/rest/services/MD_Vaccination_Locations/FeatureServer/1/query?where=1%3D1&outFields=*&outSR=4326&f=json")!
        
        
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



class TotalVaccineData: ObservableObject {
    
    @Published var sectionsRowTwo: [SectionSecondRow] = []
    @Published var sections: [Section] = []
    @Published var sectionsRowThree: [SectionThirdRow] = []
    @Published var ringView: [RingView] = []
    @Published var recentMDVaccineTotals: MDTotalVaccine?
    
    let titles = ["Number 1st Dose Given", "24 Hour Change of 1st Doses Given:", "Percent of Population 1st Dose Received", "Number 2nd Dose Received", "24 Hour Change of 2nd Doses Given", "Percent of Population 2nd Dose Received", "All Doses Administered", "Doses Recieved", "All Dose Distributed", "1st Dose Distributed", "2nd Doses Distributed" , ""]
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
                    
                    // First Row
                    
                    self.sections.append(Section(title:  self.titles[6],
                                                 text: Text("\(self.recentMDVaccineTotals?.features?[6].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                 image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                 color: .blue))
                    self.sections.append(Section(title:  self.titles[7],
                                                 text: Text("\(self.recentMDVaccineTotals?.features?[7].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                 image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                 color: .blue))
                    self.sections.append(Section(title:  self.titles[8],
                                                 text: Text("\(self.recentMDVaccineTotals?.features?[8].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                 image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                 color: .blue))
                    
                    
                    
                    // Second Row
                    self.sectionsRowTwo.append(SectionSecondRow(title:  self.titles[0],
                                                                text: Text("\(self.recentMDVaccineTotals?.features?[0].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                                image: URL(string: "https://khn.org/wp-content/uploads/sites/2/2020/12/GettyImages-1263990592_1350.jpg?w=1270")!,
                                                                logo: #imageLiteral(resourceName: "Logo1"),
                                                                color: .blue))
                    
                    self.sectionsRowTwo.append(SectionSecondRow(title:  self.titles[1],
                                                                text: Text("+\(self.recentMDVaccineTotals?.features?[1].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                                image: URL(string: "https://khn.org/wp-content/uploads/sites/2/2020/12/GettyImages-1263990592_1350.jpg?w=1270")!,
                                                                logo: #imageLiteral(resourceName: "Logo1"),
                                                                color: .blue))
                    self.sectionsRowTwo.append(SectionSecondRow(title:  self.titles[2],
                                                                text: Text("\(self.recentMDVaccineTotals?.features?[2].attributes?.Value ?? 0, specifier: "%.2f")%"),
                                                                image: URL(string: "https://khn.org/wp-content/uploads/sites/2/2020/12/GettyImages-1263990592_1350.jpg?w=1270")!,
                                                                logo: #imageLiteral(resourceName: "Logo1"),
                                                                color: .blue))
                    
                    
                    // Third Row
                    self.sectionsRowThree.append(SectionThirdRow(title:  self.titles[3],
                                                                 text: Text("\(self.recentMDVaccineTotals?.features?[3].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                                 image: URL(string: "https://labblog.uofmhealth.org/sites/lab/files/2020-08/CovidVaccineBlog_0.jpg")!,
                                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                                 color: .blue))
                    self.sectionsRowThree.append(SectionThirdRow(title:  self.titles[4],
                                                                 text: Text("+\(self.recentMDVaccineTotals?.features?[4].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                                 image: URL(string: "https://labblog.uofmhealth.org/sites/lab/files/2020-08/CovidVaccineBlog_0.jpg")!,
                                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                                 color: .blue))
                    self.sectionsRowThree.append(SectionThirdRow(title:  self.titles[5],
                                                                 text: Text("\(self.recentMDVaccineTotals?.features?[5].attributes?.Value ?? 0, specifier: "%.2f")%"),
                                                                 image: URL(string: "https://labblog.uofmhealth.org/sites/lab/files/2020-08/CovidVaccineBlog_0.jpg")!,
                                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                                 color: .blue))
                    
                    
                    
                    
                    
                } catch let jsonError {
                    
                    print("Decoding failed for Vaccine Data", jsonError)
                }
            }
            
            
        }
        
        
        // execute the HTTP request
        task.resume()
        
    }
}





